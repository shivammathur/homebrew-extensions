class Vips < Formula
  desc "Image processing library"
  homepage "https://github.com/libvips/libvips"
  url "https://github.com/libvips/libvips/releases/download/v8.15.0/vips-8.15.0.tar.xz"
  sha256 "d33f81c6ab4bd1faeedc36dc32f880b19e9d5ff69b502e59d175332dfb8f63f1"
  license "LGPL-2.1-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 arm64_sonoma:   "3dde52323459f5f3c8743c4f466e133bbb0d824478f02a357f5225f26135c7d5"
    sha256 arm64_ventura:  "fa999a3bf8c9541dc3460a7c6ee078b7d9ab355fc0fe19600a43154961eab17b"
    sha256 arm64_monterey: "34dfb0994b55aad6cba52cfab2a4dfb7234c1775117ef0a6b39b78dc539c155c"
    sha256 sonoma:         "283531c71edefa0fe95fcabf32e8ca08e70a1a34090d5e4c7e214aea23087dd8"
    sha256 ventura:        "153035b2e29a01f3fa4504d02dac52e039d178e07cc820ad5fd22fe5f49a2c25"
    sha256 monterey:       "95aaa746d5f06b25f4b148488ed96d9544166f46aad27b8dc72712146bde45fb"
    sha256 x86_64_linux:   "d9b9e53416ea83c962da3f5dbeee94c92bfe113c877b14c7d8f794744173ca27"
  end

  depends_on "gobject-introspection" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "cairo"
  depends_on "cfitsio"
  depends_on "cgif"
  depends_on "fftw"
  depends_on "fontconfig"
  depends_on "gettext"
  depends_on "glib"
  depends_on "imagemagick"
  depends_on "jpeg-xl"
  depends_on "libexif"
  depends_on "libgsf"
  depends_on "libheif"
  depends_on "libimagequant"
  depends_on "libmatio"
  depends_on "librsvg"
  depends_on "libspng"
  depends_on "libtiff"
  depends_on "little-cms2"
  depends_on "mozjpeg"
  depends_on "openexr"
  depends_on "openjpeg"
  depends_on "openslide"
  depends_on "orc"
  depends_on "pango"
  depends_on "poppler"
  depends_on "webp"

  uses_from_macos "python" => :build
  uses_from_macos "expat"
  uses_from_macos "zlib"

  fails_with gcc: "5"

  def install
    # mozjpeg needs to appear before libjpeg, otherwise it's not used
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["mozjpeg"].opt_lib/"pkgconfig"

    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    system "#{bin}/vips", "-l"
    cmd = "#{bin}/vipsheader -f width #{test_fixtures("test.png")}"
    assert_equal "8", shell_output(cmd).chomp

    # --trellis-quant requires mozjpeg, vips warns if it's not present
    cmd = "#{bin}/vips jpegsave #{test_fixtures("test.png")} #{testpath}/test.jpg --trellis-quant 2>&1"
    assert_equal "", shell_output(cmd)

    # [palette] requires libimagequant, vips warns if it's not present
    cmd = "#{bin}/vips copy #{test_fixtures("test.png")} #{testpath}/test.png[palette] 2>&1"
    assert_equal "", shell_output(cmd)
  end
end
