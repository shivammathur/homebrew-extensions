class Curl < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server"
  homepage "https://curl.se"
  # Don't forget to update both instances of the version in the GitHub mirror URL.
  url "https://curl.se/download/curl-8.7.1.tar.bz2"
  mirror "https://github.com/curl/curl/releases/download/curl-8_7_1/curl-8.7.1.tar.bz2"
  mirror "http://fresh-center.net/linux/www/curl-8.7.1.tar.bz2"
  mirror "http://fresh-center.net/linux/www/legacy/curl-8.7.1.tar.bz2"
  sha256 "05bbd2b698e9cfbab477c33aa5e99b4975501835a41b7ca6ca71de03d8849e76"
  license "curl"

  livecheck do
    url "https://curl.se/download/"
    regex(/href=.*?curl[._-]v?(.*?)\.t/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "f109fe367f5761d5fd5b1800e538330e1e40627c2b1cfc8b684406853ed7f78d"
    sha256 cellar: :any,                 arm64_ventura:  "34e96a963efa6b850d216b40c27c1cdd02ebe9a39a2d7c28fc180d004a68028b"
    sha256 cellar: :any,                 arm64_monterey: "22d7372b0c62c46c13b346c5bafdd0d4fb9b48a4bec387d1573c3083e80e6a3f"
    sha256 cellar: :any,                 sonoma:         "cabdbf0618f62f936c5480736adf309fe08746d644cfaab2fdad17b68ba5cf47"
    sha256 cellar: :any,                 ventura:        "7924233ec09083c8ea9cbcaae0058274cbd4bd384ac99f0bcaca7cf3d1cb1a24"
    sha256 cellar: :any,                 monterey:       "60707c9053cd1b81b59e179238cd3fdd1c7df0ba83876688e04f712ba1185543"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ed5fe25460d3df70e6819aedba6870e44176a8cef633fc365ecf828bb3d5f71f"
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

  # Fixes `curl: (23) Failed writing received data to disk/application`
  # Remove in next release
  patch do
    url "https://github.com/curl/curl/commit/b30d694a027eb771c02a3db0dee0ca03ccab7377.patch?full_index=1"
    sha256 "da4ae2efdf05169938c2631ba6e7bca45376f1d67abc305cf8b6a982c618df4d"
  end

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
