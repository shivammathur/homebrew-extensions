class Ghostscript < Formula
  desc "Interpreter for PostScript and PDF"
  homepage "https://www.ghostscript.com/"
  url "https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs10050/ghostpdl-10.05.0.tar.xz"
  sha256 "f154039345b6e9957b0750f872374d887d76321d52bbcc9d3b85487855e08f02"
  license "AGPL-3.0-or-later"

  # The GitHub tags omit delimiters (e.g. `gs9533` for version 9.53.3). The
  # `head` repository tags are formatted fine (e.g. `ghostpdl-9.53.3`) but a
  # version may be tagged before the release is available on GitHub, so we
  # check the version from the first-party website instead.
  livecheck do
    url "https://www.ghostscript.com/json/settings.json"
    regex(/["']GS_VER["']:\s*?["']v?(\d+(?:\.\d+)+)["']/i)
  end

  bottle do
    sha256 arm64_sequoia: "6cbde9c88319f1384977584ac324dd527b92774692b4fe9d3a756171da290522"
    sha256 arm64_sonoma:  "1c07474ec5a921abf7121a16c532585bc3d0951f1c22e6c2defbb97552fa45cc"
    sha256 arm64_ventura: "65fbdd6a025bc88dfaad552606243b63e82e05a864b8f8224c8aa1c0474bf7c8"
    sha256 sonoma:        "acf301528aa9c3102fbdd9315fb24478289a4f3f2b80636ff83b9826369cbf67"
    sha256 ventura:       "5c85945496b69b7153f68d9595d52bb74af1c5eec58c24d640bcbfc10bfa01f3"
    sha256 x86_64_linux:  "db4dee3837f02b8703b68b8753a347a9191b8811f4803a90b90a511e68fdffeb"
  end

  head do
    url "https://git.ghostscript.com/ghostpdl.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkgconf" => :build
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "jbig2dec"
  depends_on "jpeg-turbo"
  depends_on "leptonica"
  depends_on "libarchive"
  depends_on "libidn"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "little-cms2"
  depends_on "openjpeg"
  depends_on "tesseract"

  uses_from_macos "expat"
  uses_from_macos "zlib"

  conflicts_with "gambit-scheme", because: "both install `gsc` binary"
  conflicts_with "git-spice", because: "both install `gs` binary"

  # https://sourceforge.net/projects/gs-fonts/
  resource "fonts" do
    url "https://downloads.sourceforge.net/project/gs-fonts/gs-fonts/8.11%20%28base%2035%2C%20GPL%29/ghostscript-fonts-std-8.11.tar.gz"
    sha256 "0eb6f356119f2e49b2563210852e17f57f9dcc5755f350a69a46a0d641a0c401"
  end

  def install
    # Delete local vendored sources so build uses system dependencies
    libs = %w[expat freetype jbig2dec jpeg lcms2mt leptonica libpng openjpeg tesseract tiff zlib]
    libs.each { |l| rm_r(buildpath/l) }

    configure = build.head? ? "./autogen.sh" : "./configure"

    args = %w[--disable-compile-inits
              --disable-cups
              --disable-gtk
              --with-system-libtiff
              --without-x]

    # Set the correct library install names so that `brew` doesn't need to fix them up later.
    ENV["DARWIN_LDFLAGS_SO_PREFIX"] = "#{opt_lib}/"
    system configure, *args, *std_configure_args

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
