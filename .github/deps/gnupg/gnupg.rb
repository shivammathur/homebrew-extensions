class Gnupg < Formula
  desc "GNU Pretty Good Privacy (PGP) package"
  homepage "https://gnupg.org/"
  url "https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.4.1.tar.bz2"
  sha256 "76b71e5aeb443bfd910ce9cbc8281b617c8341687afb67bae455877972b59de8"
  license "GPL-3.0-or-later"

  livecheck do
    url "https://gnupg.org/ftp/gcrypt/gnupg/"
    regex(/href=.*?gnupg[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 arm64_ventura:  "d94e50794db1b573bec22f64ea4bf7e3b5789da35284e5d995ec3251a1645030"
    sha256 arm64_monterey: "2b0658379f05d1ccdca9c6d650f5253bb110d560edaabeb13d3f9d29fb6b2bb7"
    sha256 arm64_big_sur:  "8d3fe08b568828297c49fece70ce465ea53e3bbd0b4cd064dc6709cf67f92cf9"
    sha256 ventura:        "9015b3299f37f49606b798c4981f2e2fc17bad14ff71e725b3084190f5d87549"
    sha256 monterey:       "5c129acc7dccc106c6cc0655b379ad812db2c2117d7c065856b687edd9580bad"
    sha256 big_sur:        "5c39183e5e10f41b9c1cc40035f66c5b5a74224670804262b76dcbf7397cdc7b"
    sha256 x86_64_linux:   "ad4ec8417a213d4be0ece1920f85a6875028c8791255faf75a29c84de1d21a64"
  end

  depends_on "pkg-config" => :build
  depends_on "gnutls"
  depends_on "libassuan"
  depends_on "libgcrypt"
  depends_on "libgpg-error"
  depends_on "libksba"
  depends_on "libusb"
  depends_on "npth"
  depends_on "pinentry"
  depends_on "readline"

  uses_from_macos "bzip2"
  uses_from_macos "sqlite", since: :catalina
  uses_from_macos "zlib"

  on_macos do
    depends_on "gettext"
  end

  def install
    libusb = Formula["libusb"]
    ENV.append "CPPFLAGS", "-I#{libusb.opt_include}/libusb-#{libusb.version.major_minor}"

    mkdir "build" do
      system "../configure", *std_configure_args,
                             "--disable-silent-rules",
                             "--sbindir=#{bin}",
                             "--sysconfdir=#{etc}",
                             "--enable-all-tests",
                             "--with-pinentry-pgm=#{Formula["pinentry"].opt_bin}/pinentry"
      system "make"
      system "make", "check"
      system "make", "install"
    end

    # Configure scdaemon as recommended by upstream developers
    # https://dev.gnupg.org/T5415#145864
    if OS.mac?
      # write to buildpath then install to ensure existing files are not clobbered
      (buildpath/"scdaemon.conf").write <<~EOS
        disable-ccid
      EOS
      pkgetc.install "scdaemon.conf"
    end
  end

  def post_install
    (var/"run").mkpath
    quiet_system "killall", "gpg-agent"
  end

  test do
    (testpath/"batch.gpg").write <<~EOS
      Key-Type: RSA
      Key-Length: 2048
      Subkey-Type: RSA
      Subkey-Length: 2048
      Name-Real: Testing
      Name-Email: testing@foo.bar
      Expire-Date: 1d
      %no-protection
      %commit
    EOS
    begin
      system bin/"gpg", "--batch", "--gen-key", "batch.gpg"
      (testpath/"test.txt").write "Hello World!"
      system bin/"gpg", "--detach-sign", "test.txt"
      system bin/"gpg", "--verify", "test.txt.sig"
    ensure
      system bin/"gpgconf", "--kill", "gpg-agent"
    end
  end
end
