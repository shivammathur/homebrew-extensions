class Curl < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server"
  homepage "https://curl.se"
  # Don't forget to update both instances of the version in the GitHub mirror URL.
  # `url` goes below this comment when the `stable` block is removed.
  license "curl"
  revision 1

  stable do
    url "https://curl.se/download/curl-8.11.0.tar.bz2"
    mirror "https://github.com/curl/curl/releases/download/curl-8_11_0/curl-8.11.0.tar.bz2"
    mirror "http://fresh-center.net/linux/www/curl-8.11.0.tar.bz2"
    mirror "http://fresh-center.net/linux/www/legacy/curl-8.11.0.tar.bz2"
    sha256 "c95d5a1368803729345a632ce42cceeefd5f09c3b4d9582f858f6779f4b8b254"

    # Remove the following patches with `stable` block on next release.
    # Fix netrc parsing that affects git.
    # https://github.com/curl/curl/issues/15496
    patch do
      url "https://github.com/curl/curl/commit/f5c616930b5cf148b1b2632da4f5963ff48bdf88.patch?full_index=1"
      sha256 "fa1991cab62d62ef97a86aae215330e9df3d54d60dcf8338fdd98e758b87cc62"
    end
    # Fix support for larger netrc file or longer lines/tokens in it
    # https://github.com/curl/curl/issues/15513
    patch do
      url "https://github.com/curl/curl/commit/0cdde0fdfbeb8c35420f6d03fa4b77ed73497694.patch?full_index=1"
      sha256 "e1d10cb2327b4aa6b90eb153dce8b06fb4c683936edb9353fb2c9a4341cababd"
    end
  end

  livecheck do
    url "https://curl.se/download/"
    regex(/href=.*?curl[._-]v?(.*?)\.t/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "0e473c47dbd796d60e564c40f6447f406bc325aae2d0c5085074a60e2466b257"
    sha256 cellar: :any,                 arm64_sonoma:  "47b31a69fda0558adedb16bdac0d4003a3efd902a0f28a6615734dbf3c1042d1"
    sha256 cellar: :any,                 arm64_ventura: "fa50c33145ed41a6de273ce0ea9af5491f975bb34c4c1f11dfb598bc899e0c77"
    sha256 cellar: :any,                 sonoma:        "7dadb384a5a42e7a4b5607791b5e43209d825df771172aca4aea549bb8f09c8a"
    sha256 cellar: :any,                 ventura:       "e92eb6ae945a5ff54db7e4564df57b98cf02b958a7b0efbf7872103076ffabf2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "48c94b796c1615b3695ebea3b95b8f40168697e80122ca4f1266e410d3eca91c"
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
  depends_on "libnghttp2"
  depends_on "libssh2"
  depends_on "openssl@3"
  depends_on "rtmpdump"
  depends_on "zstd"

  uses_from_macos "krb5"
  uses_from_macos "openldap"
  uses_from_macos "zlib"

  on_system :linux, macos: :monterey_or_older do
    depends_on "libidn2"
  end

  def install
    tag_name = "curl-#{version.to_s.tr(".", "_")}"
    if build.stable? && stable.mirrors.grep(/github\.com/).first.exclude?(tag_name)
      odie "Tag name #{tag_name} is not found in the GitHub mirror URL! " \
           "Please make sure the URL is correct."
    end

    system "./buildconf" if build.head?

    args = %W[
      --disable-silent-rules
      --with-ssl=#{Formula["openssl@3"].opt_prefix}
      --without-ca-bundle
      --without-ca-path
      --with-ca-fallback
      --with-secure-transport
      --with-default-ssl-backend=openssl
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

    args += if OS.mac? && MacOS.version >= :ventura
      %w[
        --with-apple-idn
        --without-libidn2
      ]
    else
      %w[
        --without-apple-idn
        --with-libidn2
      ]
    end

    system "./configure", *args, *std_configure_args
    system "make", "install"
    system "make", "install", "-C", "scripts"
    libexec.install "scripts/mk-ca-bundle.pl"
  end

  test do
    # Fetch the curl tarball and see that the checksum matches.
    # This requires a network connection, but so does Homebrew in general.
    filename = (testpath/"test.tar.gz")
    system bin/"curl", "-L", stable.url, "-o", filename
    filename.verify_checksum stable.checksum

    # Check dependencies linked correctly
    curl_features = shell_output("#{bin}/curl-config --features").split("\n")
    %w[brotli GSS-API HTTP2 IDN libz SSL zstd].each do |feature|
      assert_includes curl_features, feature
    end
    curl_protocols = shell_output("#{bin}/curl-config --protocols").split("\n")
    %w[LDAPS RTMP SCP SFTP].each do |protocol|
      assert_includes curl_protocols, protocol
    end

    system libexec/"mk-ca-bundle.pl", "test.pem"
    assert_predicate testpath/"test.pem", :exist?
    assert_predicate testpath/"certdata.txt", :exist?
  end
end
