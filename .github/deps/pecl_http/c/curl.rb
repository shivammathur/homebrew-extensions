class Curl < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server"
  homepage "https://curl.se"
  # Don't forget to update both instances of the version in the GitHub mirror URL.
  # `url` goes below this comment when the `stable` block is removed.
  license "curl"

  # Remove `stable` block when patch is no longer needed.
  stable do
    url "https://curl.se/download/curl-8.10.0.tar.bz2"
    mirror "https://github.com/curl/curl/releases/download/curl-8_10_0/curl-8.10.0.tar.bz2"
    mirror "http://fresh-center.net/linux/www/curl-8.10.0.tar.bz2"
    mirror "http://fresh-center.net/linux/www/legacy/curl-8.10.0.tar.bz2"
    sha256 "be30a51f7bbe8819adf5a8e8cc6991393ede31f782b8de7b46235cc1eb7beb9f"

    # Prevents segfault in julia test - https://github.com/curl/curl/pull/14862
    patch do
      url "https://github.com/curl/curl/commit/60ac76d67bf32dfb020cd155fc27fe1f03ac404f.patch?full_index=1"
      sha256 "c9330acd41390cada341322c81affba24fb422b1123ee4360c2a617a42d6f517"
    end
  end

  livecheck do
    url "https://curl.se/download/"
    regex(/href=.*?curl[._-]v?(.*?)\.t/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "d9d4391883506d26a872dfed2aaecd1b4b56e24475d90987f8257d3085699253"
    sha256 cellar: :any,                 arm64_sonoma:   "55c7257e15917f412d8dc643f1ebe78d45852b5d21adf6c9bd57aaef10b66a59"
    sha256 cellar: :any,                 arm64_ventura:  "25298eb0770e532801a9a717e801ba85667ca1704a6cc48203c6c194f296bd42"
    sha256 cellar: :any,                 arm64_monterey: "bed918cbd5c6d1a651dab2afb36fe4618dfe2013e1725e6dbdbf77aa088e7fed"
    sha256 cellar: :any,                 sonoma:         "09c95049ffe8bbcd3d7d85bbdc1c2861ef9de3383af72cd2def501910b94d442"
    sha256 cellar: :any,                 ventura:        "5440bf2de93261bd5e90369a9251c3a3778ccd9a4ae45a515b264896648b0288"
    sha256 cellar: :any,                 monterey:       "0c78cda5623e209247941153f56b05e426e0f39fc970b7ff6eadd07db42f2d2d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3620272f06ff1d93a9895197ed7e4be6cc39936a18cf276a88a86dd1ea50ecb5"
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
