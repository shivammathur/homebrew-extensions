class Curl < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server"
  homepage "https://curl.se"
  # Don't forget to update both instances of the version in the GitHub mirror URL.
  url "https://curl.se/download/curl-8.5.0.tar.bz2"
  mirror "https://github.com/curl/curl/releases/download/curl-8_5_0/curl-8.5.0.tar.bz2"
  mirror "http://fresh-center.net/linux/www/curl-8.5.0.tar.bz2"
  mirror "http://fresh-center.net/linux/www/legacy/curl-8.5.0.tar.bz2"
  sha256 "ce4b6a6655431147624aaf582632a36fe1ade262d5fab385c60f78942dd8d87b"
  license "curl"

  livecheck do
    url "https://curl.se/download/"
    regex(/href=.*?curl[._-]v?(.*?)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "f522b5617f23fc5254ca7af46f966ab4126f1e6bb807ef6b0a5d9a189401628c"
    sha256 cellar: :any,                 arm64_ventura:  "bf6727235d2f3de1aaac9cd78a73de007c50370fbe8a617fa6274b5b0c11e17d"
    sha256 cellar: :any,                 arm64_monterey: "30624bc555daa8181e3bceb3abe88fc83be0ccfdf4481e2333599fbeb45b7922"
    sha256 cellar: :any,                 sonoma:         "47c7c2bacab6e130e55fd34a0053062ad775801a4ed6b8f8d970226b89aaaef3"
    sha256 cellar: :any,                 ventura:        "b38db0ec20251e89fcd2f71074a3ad3e9aa2bedafe9b9d4d7c368a8fbfea2e67"
    sha256 cellar: :any,                 monterey:       "4d68cb21a249d7cf410bf46ee419bb5159a8847507ecd29e4163db2feed0e1e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6b2cd50eae98f85e4ba55b4379e2351ec4408d3c547a6bed782f1eb62a797ad4"
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
