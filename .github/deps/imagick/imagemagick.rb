class Imagemagick < Formula
  desc "Tools and libraries to manipulate images in many formats"
  homepage "https://imagemagick.org/index.php"
  url "https://imagemagick.org/archive/releases/ImageMagick-7.1.1-17.tar.xz"
  sha256 "1178b2062569d83314feb9ce586eaf1144c5daa3da3784ea641cee6d28cec00b"
  license "ImageMagick"
  head "https://github.com/ImageMagick/ImageMagick.git", branch: "main"

  livecheck do
    url "https://imagemagick.org/archive/"
    regex(/href=.*?ImageMagick[._-]v?(\d+(?:\.\d+)+-\d+)\.t/i)
  end

  bottle do
    sha256 arm64_sonoma:   "c4e2edde9867131a84edd5e2301eca47f7d42a5e779b642006e3bad29014a4be"
    sha256 arm64_ventura:  "9d728add70a19a1a642d2eee8125e3d8f2bfbd779ca8b9cdc692dae76fb85672"
    sha256 arm64_monterey: "a7fd21403692122c36feed9b32eedaaf129fc8c2d69640fdac0e6cfb52ea3c86"
    sha256 arm64_big_sur:  "6ad66da9acd37b7335d901bcf305bffb376f303bcec115ba1ca092c7b8cd7c69"
    sha256 sonoma:         "ffd0d0531f0e4053b6214b38ddfc116a1c6e378c0c123e4931a07ebe5889f87e"
    sha256 ventura:        "7105a53b6c598fa90484d9aa5be844df8a7da4b62bdec6e8c85971048034f246"
    sha256 monterey:       "966e0773eb778eb280ff67bcc67fc31b3669a60537d5dc9e0957bf1ceacb6bdf"
    sha256 big_sur:        "05c38e6d59fa8f1d020763e0bc39983a29018c4efd51d050c212a314d178c8a7"
    sha256 x86_64_linux:   "2218feb0ce6d97fb642f64995f542a28d53a2409501e1977469c01ad9a9de63a"
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
