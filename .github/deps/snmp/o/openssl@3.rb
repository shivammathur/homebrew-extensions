class OpensslAT3 < Formula
  desc "Cryptography and SSL/TLS Toolkit"
  homepage "https://openssl.org/"
  url "https://github.com/openssl/openssl/releases/download/openssl-3.3.0/openssl-3.3.0.tar.gz"
  mirror "https://www.openssl.org/source/openssl-3.3.0.tar.gz"
  mirror "http://fresh-center.net/linux/misc/openssl-3.3.0.tar.gz"
  sha256 "53e66b043322a606abf0087e7699a0e033a37fa13feb9742df35c3a33b18fb02"
  license "Apache-2.0"

  livecheck do
    url "https://www.openssl.org/source/"
    regex(/href=.*?openssl[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 arm64_sonoma:   "537ea9242799c0b0214ba268a197577aae3198f629513cc1ae7f3479008166ad"
    sha256 arm64_ventura:  "7cb105fc65311277aa69b87beebe51cf4e5bee35a4ddd49123517184a0b1fcac"
    sha256 arm64_monterey: "d187613c85000dcfa0b20ab00e03bb6b5fe168ed613585bf3e6aafbe62f3bdb1"
    sha256 sonoma:         "0493185552a97607d21036b01ba4352d161396cc189074b8410e2103dde10595"
    sha256 ventura:        "7239a6fd2d2453ddbd6ef4fffa5820267c4c7ed0c164ed26286aaf856fb4fbae"
    sha256 monterey:       "758da4962b897e09e39d83c9feaab2ee0d021fc375d36257e938c68ab7feba19"
    sha256 x86_64_linux:   "ebe27077f1806776af8d7d93f715b788ccfd235bbc0868465609561b9f49674c"
  end

  depends_on "ca-certificates"

  on_linux do
    resource "Test::Harness" do
      url "https://cpan.metacpan.org/authors/id/L/LE/LEONT/Test-Harness-3.48.tar.gz"
      mirror "http://cpan.metacpan.org/authors/id/L/LE/LEONT/Test-Harness-3.48.tar.gz"
      sha256 "e73ff89c81c1a53f6baeef6816841b89d3384403ad97422a7da9d1eeb20ef9c5"
    end

    resource "Test::More" do
      url "https://cpan.metacpan.org/authors/id/E/EX/EXODIST/Test-Simple-1.302198.tar.gz"
      mirror "http://cpan.metacpan.org/authors/id/E/EX/EXODIST/Test-Simple-1.302198.tar.gz"
      sha256 "1dc07bcffd23e49983433c948de3e3f377e6e849ad7fe3432c717fa782024faa"
    end

    resource "ExtUtils::MakeMaker" do
      url "https://cpan.metacpan.org/authors/id/B/BI/BINGOS/ExtUtils-MakeMaker-7.70.tar.gz"
      mirror "http://cpan.metacpan.org/authors/id/B/BI/BINGOS/ExtUtils-MakeMaker-7.70.tar.gz"
      sha256 "f108bd46420d2f00d242825f865b0f68851084924924f92261d684c49e3e7a74"
    end
  end

  link_overwrite "bin/c_rehash", "bin/openssl", "include/openssl/*"
  link_overwrite "lib/libcrypto*", "lib/libssl*"
  link_overwrite "lib/pkgconfig/libcrypto.pc", "lib/pkgconfig/libssl.pc", "lib/pkgconfig/openssl.pc"
  link_overwrite "share/doc/openssl/*", "share/man/man*/*ssl"

  # SSLv2 died with 1.1.0, so no-ssl2 no longer required.
  # SSLv3 & zlib are off by default with 1.1.0 but this may not
  # be obvious to everyone, so explicitly state it for now to
  # help debug inevitable breakage.
  def configure_args
    args = %W[
      --prefix=#{prefix}
      --openssldir=#{openssldir}
      --libdir=#{lib}
      no-ssl3
      no-ssl3-method
      no-zlib
    ]
    on_linux do
      args += (ENV.cflags || "").split
      args += (ENV.cppflags || "").split
      args += (ENV.ldflags || "").split
    end
    args
  end

  def install
    if OS.linux?
      ENV.prepend_create_path "PERL5LIB", buildpath/"lib/perl5"
      ENV.prepend_path "PATH", buildpath/"bin"

      %w[ExtUtils::MakeMaker Test::Harness Test::More].each do |r|
        resource(r).stage do
          system "perl", "Makefile.PL", "INSTALL_BASE=#{buildpath}"
          system "make", "PERL5LIB=#{ENV["PERL5LIB"]}", "CC=#{ENV.cc}"
          system "make", "install"
        end
      end
    end

    # This could interfere with how we expect OpenSSL to build.
    ENV.delete("OPENSSL_LOCAL_CONFIG_DIR")

    # This ensures where Homebrew's Perl is needed the Cellar path isn't
    # hardcoded into OpenSSL's scripts, causing them to break every Perl update.
    # Whilst our env points to opt_bin, by default OpenSSL resolves the symlink.
    ENV["PERL"] = Formula["perl"].opt_bin/"perl" if which("perl") == Formula["perl"].opt_bin/"perl"

    arch_args = []
    if OS.mac?
      arch_args += %W[darwin64-#{Hardware::CPU.arch}-cc enable-ec_nistp_64_gcc_128]
    elsif Hardware::CPU.intel?
      arch_args << (Hardware::CPU.is_64_bit? ? "linux-x86_64" : "linux-elf")
    elsif Hardware::CPU.arm?
      arch_args << (Hardware::CPU.is_64_bit? ? "linux-aarch64" : "linux-armv4")
    end

    openssldir.mkpath
    system "perl", "./Configure", *(configure_args + arch_args)
    system "make"
    system "make", "install", "MANDIR=#{man}", "MANSUFFIX=ssl"
    system "make", "test"
  end

  def openssldir
    etc/"openssl@3"
  end

  def post_install
    rm_f openssldir/"cert.pem"
    openssldir.install_symlink Formula["ca-certificates"].pkgetc/"cert.pem"
  end

  def caveats
    <<~EOS
      A CA file has been bootstrapped using certificates from the system
      keychain. To add additional certificates, place .pem files in
        #{openssldir}/certs

      and run
        #{opt_bin}/c_rehash
    EOS
  end

  test do
    # Make sure the necessary .cnf file exists, otherwise OpenSSL gets moody.
    assert_predicate pkgetc/"openssl.cnf", :exist?,
            "OpenSSL requires the .cnf file for some functionality"

    # Check OpenSSL itself functions as expected.
    (testpath/"testfile.txt").write("This is a test file")
    expected_checksum = "e2d0fe1585a63ec6009c8016ff8dda8b17719a637405a4e23c0ff81339148249"
    system bin/"openssl", "dgst", "-sha256", "-out", "checksum.txt", "testfile.txt"
    open("checksum.txt") do |f|
      checksum = f.read(100).split("=").last.strip
      assert_equal checksum, expected_checksum
    end
  end
end
