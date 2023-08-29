class Freetype < Formula
  desc "Software library to render fonts"
  homepage "https://www.freetype.org/"
  url "https://downloads.sourceforge.net/project/freetype/freetype2/2.13.2/freetype-2.13.2.tar.xz"
  mirror "https://download.savannah.gnu.org/releases/freetype/freetype-2.13.2.tar.xz"
  sha256 "12991c4e55c506dd7f9b765933e62fd2be2e06d421505d7950a132e4f1bb484d"
  license "FTL"

  livecheck do
    url :stable
    regex(/url=.*?freetype[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "9770e7c6ca2660f431b95fc0de734cffa9e46c8598e90c735e4f9829180399b6"
    sha256 cellar: :any,                 arm64_monterey: "4ef26c08887bd123350d06201b9f5bda82fb3269a83bbe29dc5fec9820371a3e"
    sha256 cellar: :any,                 arm64_big_sur:  "5dff752be14442f4377ffeeb9103af5262acbb32884527a0de7926d265dba589"
    sha256 cellar: :any,                 ventura:        "08a4f88981b854d4b6b27947239af74840963a99950b458afa1263240e9f620b"
    sha256 cellar: :any,                 monterey:       "3364e85d2b4be0501767cb78da69a6d0c56009228b16844eb93b8348e099c44c"
    sha256 cellar: :any,                 big_sur:        "15dcad6c8d29e28da771eaf479967d255f5f3c152efc35a4d5283d785dfd49b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7f4f7449ac197844846126b6e002f7faf10b5da5b333f203e3a0a8573b970835"
  end

  depends_on "pkg-config" => :build
  depends_on "libpng"

  uses_from_macos "bzip2"
  uses_from_macos "zlib"

  def install
    # This file will be installed to bindir, so we want to avoid embedding the
    # absolute path to the pkg-config shim.
    inreplace "builds/unix/freetype-config.in", "%PKG_CONFIG%", "pkg-config"

    system "./configure", "--prefix=#{prefix}",
                          "--enable-freetype-config",
                          "--without-harfbuzz"
    system "make"
    system "make", "install"

    inreplace [bin/"freetype-config", lib/"pkgconfig/freetype2.pc"],
      prefix, opt_prefix
  end

  test do
    system bin/"freetype-config", "--cflags", "--libs", "--ftversion",
                                  "--exec-prefix", "--prefix"
  end
end
