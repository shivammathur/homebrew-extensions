class Vips < Formula
  desc "Image processing library"
  homepage "https://github.com/libvips/libvips"
  url "https://github.com/libvips/libvips/releases/download/v8.15.0/vips-8.15.0.tar.xz"
  sha256 "d33f81c6ab4bd1faeedc36dc32f880b19e9d5ff69b502e59d175332dfb8f63f1"
  license "LGPL-2.1-or-later"
  revision 1

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 arm64_sonoma:   "078279e9ff1641e99580311c235cc82f843e53520da25bb8f54cd4d2c54f4324"
    sha256 arm64_ventura:  "64c13154e13cf2803a8436ad21dbd3661edf23ce5e071df146afc68b3d8dc3d8"
    sha256 arm64_monterey: "0bbaa70e54466a77eaa1c0ad9bf863494d27cca5b5b0dc69c82b87902e1721b4"
    sha256 sonoma:         "6acebfd71c2a9f1d0deff6af82fd67ca7a7aff3bc06ee32bca3b0b1abc566496"
    sha256 ventura:        "05d5f7494fa6ca05f9921ed2cfbe784b8545ab3f57182df5d0c101dbf601541a"
    sha256 monterey:       "6c9650b657d019b878e8e87d4fe796c6839f6c4df95091695cc79732d61586c0"
    sha256 x86_64_linux:   "be9e39d54712042ca86e495c4cac83e4b4674c171b2c70967d08b502aa9dbc90"
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
  depends_on "libarchive"
  depends_on "libexif"
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
