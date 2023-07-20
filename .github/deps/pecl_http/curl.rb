class Curl < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server"
  homepage "https://curl.se"
  # Don't forget to update both instances of the version in the GitHub mirror URL.
  url "https://curl.se/download/curl-8.2.0.tar.bz2"
  mirror "https://github.com/curl/curl/releases/download/curl-8_2_0/curl-8.2.0.tar.bz2"
  mirror "http://fresh-center.net/linux/www/curl-8.2.0.tar.bz2"
  mirror "http://fresh-center.net/linux/www/legacy/curl-8.2.0.tar.bz2"
  sha256 "080aaa5bef29ab3f592101e7a95f32ddbe88b92125cb28dde479d5a104928ea4"
  license "curl"

  livecheck do
    url "https://curl.se/download/"
    regex(/href=.*?curl[._-]v?(.*?)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "1ead883686647b286d8d232be54fea7402b5bbbe2388689a358ce7791a71c4b9"
    sha256 cellar: :any,                 arm64_monterey: "a7b15228a6e00361a5a5b7ee2a7b66e4be8b3c642790eb0f72018574bd901069"
    sha256 cellar: :any,                 arm64_big_sur:  "ed5d9e2b0a356033c51aa34480b4e633ff1168a4e8c63068a6edb543eab7cd73"
    sha256 cellar: :any,                 ventura:        "f05b4a4d730bff282dbe26a28d4debeb5a1cba341bde3f86f4d755763d51a9f1"
    sha256 cellar: :any,                 monterey:       "956a6d4071f5c2821cda1af511a0244ab214fb7fefb2a9740c5ce8c313280d45"
    sha256 cellar: :any,                 big_sur:        "9a5a6fa8d44cf32ca6845d7c20a018a6cbe3df6dc792c6fd408cc5bc3df0b526"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a170d26605976fa2e3b046333e7adc6866e9a5db7a86e516ce2d0b3d4097f6a3"
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
  depends_on "openssl@3"
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
    tag_name = "curl-#{version.to_s.tr(".", "_")}"
    assert_match tag_name, stable.mirrors.grep(/github\.com/).first,
                 "Tag name #{tag_name} is not found in the GitHub mirror " \
                 "URL! Please make sure the URL is correct"

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
