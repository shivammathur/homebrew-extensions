class Curl < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server"
  homepage "https://curl.se"
  url "https://curl.se/download/curl-8.1.0.tar.bz2"
  mirror "https://github.com/curl/curl/releases/download/curl-8_0_1/curl-8.1.0.tar.bz2"
  mirror "http://fresh-center.net/linux/www/curl-8.1.0.tar.bz2"
  mirror "http://fresh-center.net/linux/www/legacy/curl-8.1.0.tar.bz2"
  sha256 "8439f39f0f5dd41f399cf60f3f6f5c3e47a4a41c96f99d991b77cecb921c553b"
  license "curl"

  livecheck do
    url "https://curl.se/download/"
    regex(/href=.*?curl[._-]v?(.*?)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "8e5a1e393f161cf6f10146044f7f30ce0603975749b54ee859f1b90d216f7786"
    sha256 cellar: :any,                 arm64_monterey: "094b5f7607428e3a4bda9c777a19caf61abaea42f89df86e26bcbaa9989885f7"
    sha256 cellar: :any,                 arm64_big_sur:  "1d231d9c586380e99d41eb17bbf67a8b9a7bf5857577c32a7a8531049995d885"
    sha256 cellar: :any,                 ventura:        "f44fa5b368804b3aa3cfad16148a0d361dada5a371a85ba4e6fb6862456a6857"
    sha256 cellar: :any,                 monterey:       "0a14cbd066a5ff2ad00f1c3c4cccaa86dc5f629f3005c3b32652b1f08eafa00a"
    sha256 cellar: :any,                 big_sur:        "cb88dcdd0469c441a4a8b57c3e33c1036e36172f9a799182bb30afa83607ea2d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3fa046584287e650ff315481486f0232c9dc572f2b73d6a49dd9497d18fb0b2a"
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
  depends_on "openldap"
  depends_on "openssl@1.1"
  depends_on "rtmpdump"
  depends_on "zstd"

  uses_from_macos "krb5"
  uses_from_macos "zlib"

  def install
    system "./buildconf" if build.head?

    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --with-ssl=#{Formula["openssl@1.1"].opt_prefix}
      --without-ca-bundle
      --without-ca-path
      --with-ca-fallback
      --with-secure-transport
      --with-default-ssl-backend=openssl
      --with-libidn2
      --with-librtmp
      --with-libssh2
      --without-libpsl
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
