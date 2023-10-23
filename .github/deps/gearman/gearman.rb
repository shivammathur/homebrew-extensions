class Gearman < Formula
  desc "Application framework to farm out work to other machines or processes"
  homepage "http://gearman.org/"
  url "https://github.com/gearman/gearmand/releases/download/1.1.20/gearmand-1.1.20.tar.gz"
  sha256 "2f60fa207dcd730595ef96a9dc3ca899566707c8176106b3c63ecf47edc147a6"
  license "BSD-3-Clause"
  revision 3

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "807d2258b52329a7ddc3d62e6a0df3816179bd32a24bb0585ff33d82f22b3b3b"
    sha256 cellar: :any,                 arm64_ventura:  "82c69e50e4b45381b8324293fa7dd2b02e11369912c56ca0a59fdf4c72f70182"
    sha256 cellar: :any,                 arm64_monterey: "995d2f4cbd2cbbfa5b6f99eee159a676a03b68e8669e914d82c5ee22c85e9c5b"
    sha256 cellar: :any,                 sonoma:         "5d6f7b04b10c35e90ced555e6c49e5b77ed21eddfc4811e581827d64f2d4752a"
    sha256 cellar: :any,                 ventura:        "6aa468ad8c66ad4e302205286dae84cd14cbe2fe23c40dba8c3f5c208cebc704"
    sha256 cellar: :any,                 monterey:       "08dc516ddcbe91c8fecc414237d4a3f9edd0ef0cf7dd9343a6b443b695aade17"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eca25044336e9fbac6311f19faf92c4113037e52dd9bf9fd14c1623382d85883"
  end

  depends_on "pkg-config" => :build
  depends_on "sphinx-doc" => :build
  depends_on "boost"
  depends_on "libevent"
  depends_on "libmemcached"

  uses_from_macos "gperf" => :build
  uses_from_macos "sqlite"

  on_linux do
    depends_on "util-linux" # for libuuid
  end

  def install
    # Work around "error: no member named 'signbit' in the global namespace"
    # encountered when trying to detect boost regex in configure
    if MacOS.version == :high_sierra
      ENV.delete("HOMEBREW_SDKROOT")
      ENV.delete("SDKROOT")
    end

    # https://bugs.launchpad.net/gearmand/+bug/1368926
    Dir["tests/**/*.cc", "libtest/main.cc"].each do |test_file|
      next unless File.read(test_file).include?("std::unique_ptr")

      inreplace test_file, "std::unique_ptr", "std::auto_ptr"
    end

    args = %W[
      --prefix=#{prefix}
      --localstatedir=#{var}
      --disable-silent-rules
      --disable-dependency-tracking
      --disable-cyassl
      --disable-hiredis
      --disable-libdrizzle
      --disable-libpq
      --disable-libtokyocabinet
      --disable-ssl
      --enable-libmemcached
      --with-boost=#{Formula["boost"].opt_prefix}
      --with-memcached=#{Formula["memcached"].opt_bin}/memcached
      --with-sqlite3
      --without-mysql
      --without-postgresql
    ]

    ENV.append_to_cflags "-DHAVE_HTONLL"

    (var/"log").mkpath
    system "./configure", *args
    system "make", "install"
  end

  service do
    run opt_sbin/"gearmand"
  end

  test do
    assert_match(/gearman\s*Error in usage/, shell_output("#{bin}/gearman --version 2>&1", 1))
  end
end
