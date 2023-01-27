class Guile < Formula
  desc "GNU Ubiquitous Intelligent Language for Extensions"
  homepage "https://www.gnu.org/software/guile/"
  url "https://ftp.gnu.org/gnu/guile/guile-3.0.9.tar.xz"
  mirror "https://ftpmirror.gnu.org/guile/guile-3.0.9.tar.xz"
  sha256 "1a2625ac72b2366e95792f3fe758fd2df775b4044a90a4a9787326e66c0d750d"
  license "LGPL-3.0-or-later"

  bottle do
    sha256 arm64_ventura:  "c19a09aefa173045b658cd01ff1d17415f7f9f82c71a53011d83b656317c09e7"
    sha256 arm64_monterey: "ddfffea5985814ae9799e24ed9e76dd41498c47253afb1ea3c7c03cea03a2ecb"
    sha256 arm64_big_sur:  "b2f76cff34fb8136665a9306235db817844bd440fad61e1886fb0fb94d530b88"
    sha256 ventura:        "b3665ca29b94ffc47d5a208f5e159b6de82046f352a79cf37cf16cdd84a62573"
    sha256 monterey:       "2680f7c109ed8ff19d28846a91d192563d2fe6ce41a6492d0d9e2a416bae6dd9"
    sha256 big_sur:        "94aab47e1449b6535a233a7266ddefc65fd5f316182c58d4db11c3745e88544b"
    sha256 x86_64_linux:   "a70bb44636a8afe8f60592652964028b3c5bd5fcd6ff642567b7137391128d16"
  end

  head do
    url "https://git.savannah.gnu.org/git/guile.git", branch: "main"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "gettext" => :build
    uses_from_macos "flex" => :build
  end

  # Remove with Guile 3.0.9 release.
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gettext" => :build

  depends_on "gnu-sed" => :build
  depends_on "bdw-gc"
  depends_on "gmp"
  depends_on "libtool"
  depends_on "libunistring"
  depends_on "pkg-config" # guile-config is a wrapper around pkg-config.
  depends_on "readline"

  # Remove with Guile 3.0.9 release.
  uses_from_macos "flex" => :build

  uses_from_macos "gperf"
  uses_from_macos "libffi", since: :catalina
  uses_from_macos "libxcrypt"

  def install
    # Avoid superenv shim
    inreplace "meta/guile-config.in", "@PKG_CONFIG@", Formula["pkg-config"].opt_bin/"pkg-config"

    system "./autogen.sh" unless build.stable?

    # Remove with Guile 3.0.9 release.
    system "autoreconf", "-vif" if OS.mac? && build.stable?

    system "./configure", *std_configure_args,
                          "--with-libreadline-prefix=#{Formula["readline"].opt_prefix}",
                          "--with-libgmp-prefix=#{Formula["gmp"].opt_prefix}",
                          "--disable-nls"
    system "make", "install"

    # A really messed up workaround required on macOS --mkhl
    Pathname.glob("#{lib}/*.dylib") do |dylib|
      lib.install_symlink dylib.basename => "#{dylib.basename(".dylib")}.so"
    end

    # This is either a solid argument for guile including options for
    # --with-xyz-prefix= for libffi and bdw-gc or a solid argument for
    # Homebrew automatically removing Cellar paths from .pc files in favour
    # of opt_prefix usage everywhere.
    inreplace lib/"pkgconfig/guile-3.0.pc" do |s|
      s.gsub! Formula["bdw-gc"].prefix.realpath, Formula["bdw-gc"].opt_prefix
      s.gsub! Formula["libffi"].prefix.realpath, Formula["libffi"].opt_prefix if MacOS.version < :catalina
    end

    (share/"gdb/auto-load").install Dir["#{lib}/*-gdb.scm"]
  end

  def post_install
    # Create directories so installed modules can create links inside.
    (HOMEBREW_PREFIX/"lib/guile/3.0/site-ccache").mkpath
    (HOMEBREW_PREFIX/"lib/guile/3.0/extensions").mkpath
    (HOMEBREW_PREFIX/"share/guile/site/3.0").mkpath
  end

  def caveats
    <<~EOS
      Guile libraries can now be installed here:
          Source files: #{HOMEBREW_PREFIX}/share/guile/site/3.0
        Compiled files: #{HOMEBREW_PREFIX}/lib/guile/3.0/site-ccache
            Extensions: #{HOMEBREW_PREFIX}/lib/guile/3.0/extensions

      Add the following to your .bashrc or equivalent:
        export GUILE_LOAD_PATH="#{HOMEBREW_PREFIX}/share/guile/site/3.0"
        export GUILE_LOAD_COMPILED_PATH="#{HOMEBREW_PREFIX}/lib/guile/3.0/site-ccache"
        export GUILE_SYSTEM_EXTENSIONS_PATH="#{HOMEBREW_PREFIX}/lib/guile/3.0/extensions"
    EOS
  end

  test do
    hello = testpath/"hello.scm"
    hello.write <<~EOS
      (display "Hello World")
      (newline)
    EOS

    ENV["GUILE_AUTO_COMPILE"] = "0"

    system bin/"guile", hello
  end
end
