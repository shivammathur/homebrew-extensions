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

    # Fix netrc parsing that affects git.
    # Remove with `stable` block on next release.
    # https://github.com/curl/curl/issues/15496
    patch do
      url "https://github.com/curl/curl/commit/d8010d956f09069d1d6b474abdee5864569e6920.patch?full_index=1"
      sha256 "98dfd5a21f7de0084163fc1e1f7c0cdd56185dd78a2599c95585a777d06191cd"
    end
  end

  livecheck do
    url "https://curl.se/download/"
    regex(/href=.*?curl[._-]v?(.*?)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "05cdbd5a5239f020ad8fc9f404124d07bcaafdfeca41dff6df3ac651fb178cb8"
    sha256 cellar: :any,                 arm64_sonoma:  "4377a15e290a54c2fdff7767a2fbd23e1af8038e0d0ebb9f4093380393b6e3e7"
    sha256 cellar: :any,                 arm64_ventura: "441834e35458af4f0cbb3cb1d58653be4cf64e557b937cf852148e53e363e01e"
    sha256 cellar: :any,                 sonoma:        "69c4657fbd079a9192933f1205b50f690f018037d83e53ce10df680f557541cb"
    sha256 cellar: :any,                 ventura:       "bd40aabe7d09572350a12a64e9f49a6525928953b0f898ae60279a68440958d7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b42beac54aca92af753ad9fb27d24baa404cf5ad97c7ed80e95bf93673bac051"
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
