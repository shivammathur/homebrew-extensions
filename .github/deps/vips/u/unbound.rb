class Unbound < Formula
  desc "Validating, recursive, caching DNS resolver"
  homepage "https://www.unbound.net"
  url "https://nlnetlabs.nl/downloads/unbound/unbound-1.19.0.tar.gz"
  sha256 "a97532468854c61c2de48ca4170de854fd3bc95c8043bb0cfb0fe26605966624"
  license "BSD-3-Clause"
  head "https://github.com/NLnetLabs/unbound.git", branch: "master"

  # We check the GitHub repo tags instead of
  # https://nlnetlabs.nl/downloads/unbound/ since the first-party site has a
  # tendency to lead to an `execution expired` error.
  livecheck do
    url :head
    regex(/^(?:release-)?v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 arm64_sonoma:   "8af0f486394c4535e394f3c5f6c32f59bb290d469270f2f71ac4bb1c0732bb19"
    sha256 arm64_ventura:  "5c0001680762d8221915b96bcd56e33f5c63b951c713dc49f0154badd8e3b52e"
    sha256 arm64_monterey: "7fc58e7a9f0546225ef80556bfc5f949c49cb3acac8e6ed47a236844d06c79a8"
    sha256 sonoma:         "906bef01d62451f3a38011664385fb0e21aeb03055416314962baffc65c339c9"
    sha256 ventura:        "57a3eca68a54e6b49df72e49e8b2b72d85c1abc3dc9c2802bce637d66a767795"
    sha256 monterey:       "4411b98e53ec536c2de56faa343cbec303082ccecd385ce085c2f6b2d28ebb44"
    sha256 x86_64_linux:   "441cecb4591f00aa52dce8eda2d1b98400f622f73ad6cc64a6c202cd74969feb"
  end

  depends_on "libevent"
  depends_on "libnghttp2"
  depends_on "openssl@3"

  uses_from_macos "expat"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --enable-event-api
      --enable-tfo-client
      --enable-tfo-server
      --with-libevent=#{Formula["libevent"].opt_prefix}
      --with-libnghttp2=#{Formula["libnghttp2"].opt_prefix}
      --with-ssl=#{Formula["openssl@3"].opt_prefix}
    ]

    args << "--with-libexpat=#{MacOS.sdk_path}/usr" if OS.mac? && MacOS.sdk_path_if_needed
    args << "--with-libexpat=#{Formula["expat"].opt_prefix}" if OS.linux?
    system "./configure", *args

    inreplace "doc/example.conf", 'username: "unbound"', 'username: "@@HOMEBREW-UNBOUND-USER@@"'
    system "make"
    system "make", "install"
  end

  def post_install
    conf = etc/"unbound/unbound.conf"
    return unless conf.exist?
    return unless conf.read.include?('username: "@@HOMEBREW-UNBOUND-USER@@"')

    inreplace conf, 'username: "@@HOMEBREW-UNBOUND-USER@@"',
                    "username: \"#{ENV["USER"]}\""
  end

  service do
    run [opt_sbin/"unbound", "-d", "-c", etc/"unbound/unbound.conf"]
    keep_alive true
    require_root true
  end

  test do
    system sbin/"unbound-control-setup", "-d", testpath
  end
end
