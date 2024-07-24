class Curl < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server"
  homepage "https://curl.se"
  # Don't forget to update both instances of the version in the GitHub mirror URL.
  url "https://curl.se/download/curl-8.8.0.tar.bz2"
  mirror "https://github.com/curl/curl/releases/download/curl-8_8_0/curl-8.8.0.tar.bz2"
  mirror "http://fresh-center.net/linux/www/curl-8.8.0.tar.bz2"
  mirror "http://fresh-center.net/linux/www/legacy/curl-8.8.0.tar.bz2"
  sha256 "40d3792d38cfa244d8f692974a567e9a5f3387c547579f1124e95ea2a1020d0d"
  license "curl"

  livecheck do
    url "https://curl.se/download/"
    regex(/href=.*?curl[._-]v?(.*?)\.t/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "bc8132ec0801b0424847779b9d166df631206350f498a94be4c60acc54bd2632"
    sha256 cellar: :any,                 arm64_ventura:  "62b31756d29a3e075cbd535f394c09608b37575699c645dd38940aac348f8f43"
    sha256 cellar: :any,                 arm64_monterey: "d7c937ccbdb88a479ef59fedff0ff87e8682c07da0d1b82cba0d7cb4286c0bc7"
    sha256 cellar: :any,                 sonoma:         "cf27c98e8c217202001cc4ff9f51e65d2c8ab35c4ce71e431838f1564bfbbe87"
    sha256 cellar: :any,                 ventura:        "77964c43a5dab72136ba23d39d22372e0163620c16551a524ee258a9c078db87"
    sha256 cellar: :any,                 monterey:       "82fadaf6b7d23af8e8e3ef6ad35fa2cd246585dea5620c86a779b3c4469b8a71"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7dda21443d095d3c0f36b8a728e83553c234fbc9a7bfedf149516dbebf1c2744"
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
