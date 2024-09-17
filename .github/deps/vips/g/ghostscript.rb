class Ghostscript < Formula
  desc "Interpreter for PostScript and PDF"
  homepage "https://www.ghostscript.com/"
  license "AGPL-3.0-or-later"

  stable do
    url "https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs10031/ghostpdl-10.03.1.tar.xz"
    sha256 "05eee45268f6bb2c6189f9a40685c4608ca089443a93f2af5f5194d83dc368db"

    on_macos do
      # 1. Prevent dependent rebuilds on minor version bumps.
      # Reported upstream at:
      #   https://bugs.ghostscript.com/show_bug.cgi?id=705907
      patch :DATA
    end

    # Backport fix for missing pointer dereference
    # https://bugs.ghostscript.com/show_bug.cgi?id=707649
    patch do
      url "https://github.com/ArtifexSoftware/ghostpdl/commit/90cabe08422afdd16bac5dd9217602679d943045.patch?full_index=1"
      sha256 "deed9573aa17adbab2776f44b58a851b5aac06e2cdd99440169ca16ec9504de0"
    end
  end

  # The GitHub tags omit delimiters (e.g. `gs9533` for version 9.53.3). The
  # `head` repository tags are formatted fine (e.g. `ghostpdl-9.53.3`) but a
  # version may be tagged before the release is available on GitHub, so we
  # check the version from the first-party website instead.
  livecheck do
    url "https://www.ghostscript.com/json/settings.json"
    regex(/["']GS_VER["']:\s*?["']v?(\d+(?:\.\d+)+)["']/i)
  end

  bottle do
    rebuild 1
    sha256 arm64_sequoia:  "c5f70c8ebed71bf33bfc579776e9d0b161dd2a6cb2b5db19d63c09a366d361d4"
    sha256 arm64_sonoma:   "b0d9503a7efa718b2c1c2994b442065e79cf3a7807402944e19d278391766077"
    sha256 arm64_ventura:  "7bd21d992e534be507dd7d457c6a0b1cdf76ef1743976276c1eaa256bca2306c"
    sha256 arm64_monterey: "ac3c82a2bccbea544614781dc85aa1400d1665d40e37f1df1de0986daa76e1f0"
    sha256 sonoma:         "42ea47a742a77e6b96346d8989cbe9dbeed019537865aa38e61209fe73e28bc4"
    sha256 ventura:        "1f4b9b7577337c6702d6891d1ad686cca240c9895135b917d3bc146c580a9d86"
    sha256 monterey:       "ea25cdd4def41ef333c0503b3101d6baf6a47505cd585de55d1e0cba88426f53"
    sha256 x86_64_linux:   "b2b04161201e1f17a9ca9511e0579ae97d65a40f4bc7d195865ac7f5d8c972f6"
  end

  head do
    url "https://git.ghostscript.com/ghostpdl.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "jbig2dec"
  depends_on "jpeg-turbo"
  depends_on "libidn"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "little-cms2"
  depends_on "openjpeg"

  uses_from_macos "expat"
  uses_from_macos "zlib"

  conflicts_with "gambit-scheme", because: "both install `gsc` binary"

  fails_with gcc: "5"

  # https://sourceforge.net/projects/gs-fonts/
  resource "fonts" do
    url "https://downloads.sourceforge.net/project/gs-fonts/gs-fonts/8.11%20%28base%2035%2C%20GPL%29/ghostscript-fonts-std-8.11.tar.gz"
    sha256 "0eb6f356119f2e49b2563210852e17f57f9dcc5755f350a69a46a0d641a0c401"
  end

  def install
    # Delete local vendored sources so build uses system dependencies
    libs = %w[expat freetype jbig2dec jpeg lcms2mt libpng openjpeg tiff zlib]
    libs.each { |l| rm_r(buildpath/l) }

    configure = build.head? ? "./autogen.sh" : "./configure"

    args = %w[--disable-compile-inits
              --disable-cups
              --disable-gtk
              --with-system-libtiff
              --without-x]
    # Work around neon detection bug: https://bugs.ghostscript.com/show_bug.cgi?id=707993
    odie "`--disable-neon` workaround should be removed!" if build.stable? && version > "10.03.1"
    args << "--disable-neon" if DevelopmentTools.clang_build_version >= 1600
    system configure, *std_configure_args, *args

    # Install binaries and libraries
    system "make", "install"
    ENV.deparallelize { system "make", "install-so" }

    (pkgshare/"fonts").install resource("fonts")
  end

  test do
    ps = test_fixtures("test.ps")
    assert_match "Hello World!", shell_output("#{bin}/ps2ascii #{ps}")
  end
end

__END__
diff --git a/base/unix-dll.mak b/base/unix-dll.mak
index 89dfa5a..c907831 100644
--- a/base/unix-dll.mak
+++ b/base/unix-dll.mak
@@ -100,10 +100,26 @@ GS_DLLEXT=$(DLL_EXT)
 
 
 # MacOS X
-#GS_SOEXT=dylib
-#GS_SONAME=$(GS_SONAME_BASE).$(GS_SOEXT)
-#GS_SONAME_MAJOR=$(GS_SONAME_BASE).$(GS_VERSION_MAJOR).$(GS_SOEXT)
-#GS_SONAME_MAJOR_MINOR=$(GS_SONAME_BASE).$(GS_VERSION_MAJOR).$(GS_VERSION_MINOR).$(GS_SOEXT)
+GS_SOEXT=dylib
+GS_SONAME=$(GS_SONAME_BASE).$(GS_SOEXT)
+GS_SONAME_MAJOR=$(GS_SONAME_BASE).$(GS_VERSION_MAJOR).$(GS_SOEXT)
+GS_SONAME_MAJOR_MINOR=$(GS_SONAME_BASE).$(GS_VERSION_MAJOR).$(GS_VERSION_MINOR).$(GS_SOEXT)
+
+PCL_SONAME=$(PCL_SONAME_BASE).$(GS_SOEXT)
+PCL_SONAME_MAJOR=$(PCL_SONAME_BASE).$(GS_VERSION_MAJOR).$(GS_SOEXT)
+PCL_SONAME_MAJOR_MINOR=$(PCL_SONAME_BASE).$(GS_VERSION_MAJOR).$(GS_VERSION_MINOR).$(GS_SOEXT)
+
+XPS_SONAME=$(XPS_SONAME_BASE).$(GS_SOEXT)
+XPS_SONAME_MAJOR=$(XPS_SONAME_BASE).$(GS_VERSION_MAJOR).$(GS_SOEXT)
+XPS_SONAME_MAJOR_MINOR=$(XPS_SONAME_BASE).$(GS_VERSION_MAJOR).$(GS_VERSION_MINOR).$(GS_SOEXT)
+
+PDF_SONAME=$(PDF_SONAME_BASE).$(GS_SOEXT)
+PDF_SONAME_MAJOR=$(PDF_SONAME_BASE).$(GS_VERSION_MAJOR).$(GS_SOEXT)
+PDF_SONAME_MAJOR_MINOR=$(PDF_SONAME_BASE).$(GS_VERSION_MAJOR).$(GS_VERSION_MINOR).$(GS_SOEXT)
+
+GPDL_SONAME=$(GPDL_SONAME_BASE).$(GS_SOEXT)
+GPDL_SONAME_MAJOR=$(GPDL_SONAME_BASE).$(GS_VERSION_MAJOR).$(GS_SOEXT)
+GPDL_SONAME_MAJOR_MINOR=$(GPDL_SONAME_BASE).$(GS_VERSION_MAJOR).$(GS_VERSION_MINOR).$(GS_SOEXT)
 #LDFLAGS_SO=-dynamiclib -flat_namespace
 #LDFLAGS_SO_MAC=-dynamiclib -install_name $(GS_SONAME_MAJOR_MINOR)
 #LDFLAGS_SO=-dynamiclib -install_name $(FRAMEWORK_NAME)
