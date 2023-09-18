class Imagemagick < Formula
  desc "Tools and libraries to manipulate images in many formats"
  homepage "https://imagemagick.org/index.php"
  url "https://imagemagick.org/archive/releases/ImageMagick-7.1.1-16.tar.xz"
  sha256 "059a51a9f61000a82a2d2974372eddbec9ce3d420c7493187388c1b0d49b90c0"
  license "ImageMagick"
  head "https://github.com/ImageMagick/ImageMagick.git", branch: "main"

  livecheck do
    url "https://imagemagick.org/archive/"
    regex(/href=.*?ImageMagick[._-]v?(\d+(?:\.\d+)+-\d+)\.t/i)
  end

  bottle do
    sha256 arm64_sonoma:   "88113aaccc3f6d6c51a0c5417f531edf57c4ce066ad5c9e6a919741a7a9fce8d"
    sha256 arm64_ventura:  "7c8358cc2b65413eada604d0676f9d7a23cdfdb100c90f2d5b0088d981e42d74"
    sha256 arm64_monterey: "5b738997380f35568dd6a7a7cb7298b74f15772321a4836393b1a543d7523315"
    sha256 arm64_big_sur:  "8e808952d2eba588b07171da52dd4e072cc2f54c5bf9cba6df9c08f189ae8dfe"
    sha256 sonoma:         "60a35208405188a5c924786d6e71e3b0f4ea5d223692dfa67101cfa8c4780e16"
    sha256 ventura:        "31734a0ebb5b4f1e69871fb45366421c0cffd38d0d1d535f793877fe3a69982e"
    sha256 monterey:       "fe401d86c2a1b0a444c45cff2c6c4ba5d2002ec1cdfd6f13c8dc79424f28d704"
    sha256 big_sur:        "f924348180193235fa711534f390486a0dbafd4f5fe353f59499820ffdc94ba1"
    sha256 x86_64_linux:   "4dd41a1a46500f3332cbcdc56164298e1e9393e06e06cd1054f7750e51675a3d"
  end

  depends_on "pkg-config" => :build
  depends_on "freetype"
  depends_on "ghostscript"
  depends_on "jpeg-turbo"
  depends_on "libheif"
  depends_on "liblqr"
  depends_on "libpng"
  depends_on "libraw"
  depends_on "libtiff"
  depends_on "libtool"
  depends_on "little-cms2"
  depends_on "openexr"
  depends_on "openjpeg"
  depends_on "webp"
  depends_on "xz"

  uses_from_macos "bzip2"
  uses_from_macos "libxml2"
  uses_from_macos "zlib"

  on_macos do
    depends_on "libomp"
  end

  on_linux do
    depends_on "libx11"
  end

  skip_clean :la

  def install
    # Avoid references to shim
    inreplace Dir["**/*-config.in"], "@PKG_CONFIG@", Formula["pkg-config"].opt_bin/"pkg-config"
    # versioned stuff in main tree is pointless for us
    inreplace "configure", "${PACKAGE_NAME}-${PACKAGE_BASE_VERSION}", "${PACKAGE_NAME}"

    args = [
      "--enable-osx-universal-binary=no",
      "--disable-silent-rules",
      "--disable-opencl",
      "--enable-shared",
      "--enable-static",
      "--with-freetype=yes",
      "--with-gvc=no",
      "--with-modules",
      "--with-openjp2",
      "--with-openexr",
      "--with-webp=yes",
      "--with-heic=yes",
      "--with-raw=yes",
      "--with-gslib",
      "--with-gs-font-dir=#{HOMEBREW_PREFIX}/share/ghostscript/fonts",
      "--with-lqr",
      "--without-djvu",
      "--without-fftw",
      "--without-pango",
      "--without-wmf",
      "--enable-openmp",
    ]
    if OS.mac?
      args += [
        "--without-x",
        # Work around "checking for clang option to support OpenMP... unsupported"
        "ac_cv_prog_c_openmp=-Xpreprocessor -fopenmp",
        "ac_cv_prog_cxx_openmp=-Xpreprocessor -fopenmp",
        "LDFLAGS=-lomp -lz",
      ]
    end

    system "./configure", *std_configure_args, *args
    system "make", "install"
  end

  test do
    assert_match "PNG", shell_output("#{bin}/identify #{test_fixtures("test.png")}")

    # Check support for recommended features and delegates.
    features = shell_output("#{bin}/magick -version")
    %w[Modules freetype heic jpeg png raw tiff].each do |feature|
      assert_match feature, features
    end

    # Check support for a few specific image formats, mostly to ensure LibRaw linked correctly.
    formats = shell_output("#{bin}/magick -list format")
    ["AVIF  HEIC      rw+", "ARW  DNG       r--", "DNG  DNG       r--"].each do |format|
      assert_match format, formats
    end
    assert_match "Helvetica", shell_output("#{bin}/magick -list font")
  end
end
