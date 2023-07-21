class Vips < Formula
  desc "Image processing library"
  homepage "https://github.com/libvips/libvips"
  url "https://github.com/libvips/libvips/releases/download/v8.14.3/vips-8.14.3.tar.xz"
  sha256 "f884d61a6b54c99cdae855001c8b9523e13b4982be7e76cac03faccb91be105c"
  license "LGPL-2.1-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 arm64_ventura:  "738b579bf0a9ca1451084a3e6131d76d9a65630bc7ed919d6afa9ecb3e83c1fe"
    sha256 arm64_monterey: "d203896a72ff98855d0cd16f65d436844b3a0c52740f558e0e4f2a8bf91ce171"
    sha256 arm64_big_sur:  "290d46d540a48e99cf8f03cde06905f5bd9c97eef56465f38d8b3bccf1015b2d"
    sha256 ventura:        "4e7b98aaa3e75eacd2a74602be2674cda01a1667b643925e3df0699f141a1523"
    sha256 monterey:       "9677cfb3676af73199c8574200586979041cf2aef8e9803dfb676624bd86c6c6"
    sha256 big_sur:        "f028a3d1a5d3b2a4b19a837fee657e3f72c7eba951dce480a329a7c22682f1b3"
    sha256 x86_64_linux:   "ed66bca9afe0046a6e25b2ad33aa2751fc42f89280f1f14c70af9a6cafc73662"
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

  uses_from_macos "expat"
  uses_from_macos "zlib"

  fails_with gcc: "5"

  def install
    # mozjpeg needs to appear before libjpeg, otherwise it's not used
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["mozjpeg"].opt_lib/"pkgconfig"

    mkdir "build" do
      system "meson", *std_meson_args, ".."
      system "ninja"
      system "ninja", "install"
    end
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
