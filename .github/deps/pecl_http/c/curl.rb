class Curl < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server"
  homepage "https://curl.se"
  # Don't forget to update both instances of the version in the GitHub mirror URL.
  url "https://curl.se/download/curl-8.9.0.tar.bz2"
  mirror "https://github.com/curl/curl/releases/download/curl-8_9_0/curl-8.9.0.tar.bz2"
  mirror "http://fresh-center.net/linux/www/curl-8.9.0.tar.bz2"
  mirror "http://fresh-center.net/linux/www/legacy/curl-8.9.0.tar.bz2"
  sha256 "1cb4c3657bd092b8c8e586afe87679c0aaa3d761af2aebabd6effd553e57936c"
  license "curl"

  livecheck do
    url "https://curl.se/download/"
    regex(/href=.*?curl[._-]v?(.*?)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "3ea92a3c87baa57a8560145d3b5c04764b57bcead38aee9f4dbb5abe0ae9bb5a"
    sha256 cellar: :any,                 arm64_ventura:  "2917eac8398eca5fe9b3e558868f79eff0065dca39482f057642940d182a1c57"
    sha256 cellar: :any,                 arm64_monterey: "97e7416d4ad72938d6a954b2551a33001fa8343bc2c5eba0c65487ed96e73c95"
    sha256 cellar: :any,                 sonoma:         "06ca318604b8749e691ff73e29f0188598dbf5fec10389e90d6ba5af8ef411ca"
    sha256 cellar: :any,                 ventura:        "2fcc5d2866470c65e6ebd22e836052b7cf8aeb4043edaca7c54a80d24da2938f"
    sha256 cellar: :any,                 monterey:       "145882d1e5e5ef68641dce88f9d93079cd595d1d654b6931ff65fa044c54a364"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "429d393da10784a69d02558f8623f4c34d1c61f7adcff01234b598c8b21a454c"
  end

  head do
    url "https://github.com/curl/curl.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  keg_only :provided_by_macos

  depends_on "pkg-config" => :build
  depends_on "brotli"
  depends_on "libidn2"
  depends_on "libnghttp2"
  depends_on "libssh2"
  depends_on "openssl@3"
  depends_on "rtmpdump"
  depends_on "zstd"

  uses_from_macos "krb5"
  uses_from_macos "openldap"
  uses_from_macos "zlib"

  def install
    tag_name = "curl-#{version.to_s.tr(".", "_")}"
    if build.stable? && stable.mirrors.grep(/github\.com/).first.exclude?(tag_name)
      odie "Tag name #{tag_name} is not found in the GitHub mirror URL! " \
           "Please make sure the URL is correct."
    end

    system "./buildconf" if build.head?

    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --with-ssl=#{Formula["openssl@3"].opt_prefix}
      --without-ca-bundle
      --without-ca-path
      --with-ca-fallback
      --with-secure-transport
      --with-default-ssl-backend=openssl
      --with-libidn2
      --with-librtmp
      --with-libssh2
      --without-libpsl
      --with-zsh-functions-dir=#{zsh_completion}
      --with-fish-functions-dir=#{fish_completion}
    ]

    args << if OS.mac?
      "--with-gssapi"
    else
      "--with-gssapi=#{Formula["krb5"].opt_prefix}"
    end

    system "./configure", *args
    system "make", "install"
    system "make", "install", "-C", "scripts"
    libexec.install "scripts/mk-ca-bundle.pl"
  end

  test do
    # Fetch the curl tarball and see that the checksum matches.
    # This requires a network connection, but so does Homebrew in general.
    filename = (testpath/"test.tar.gz")
    system "#{bin}/curl", "-L", stable.url, "-o", filename
    filename.verify_checksum stable.checksum

    system libexec/"mk-ca-bundle.pl", "test.pem"
    assert_predicate testpath/"test.pem", :exist?
    assert_predicate testpath/"certdata.txt", :exist?
  end
end
