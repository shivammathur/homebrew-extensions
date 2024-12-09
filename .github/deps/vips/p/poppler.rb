class Poppler < Formula
  desc "PDF rendering library (based on the xpdf-3.0 code base)"
  homepage "https://poppler.freedesktop.org/"
  url "https://poppler.freedesktop.org/poppler-24.12.0.tar.xz"
  sha256 "1cf374c3146f3f685d9257701bf0c2866c61d6c202c14d1f5c01a1f3a089028a"
  license "GPL-2.0-only"
  head "https://gitlab.freedesktop.org/poppler/poppler.git", branch: "master"

  livecheck do
    url :homepage
    regex(/href=.*?poppler[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 arm64_sequoia: "d428b4980bab0d71ad39c214f0afc4d1a8b252cecb53072ef8bb70a37eda6149"
    sha256 arm64_sonoma:  "621f8c1071c942c07cfc7e306f27cf052ab7e292cbaed6f31c59c142c97bb47a"
    sha256 arm64_ventura: "7ef5dc88818aac965107a126ae557b44c76dd96e256511b359a048f5ccd82f87"
    sha256 sonoma:        "40349f56b130c7e91a7ae83086f7c3ae80c65d102b794b39eee929716c43159f"
    sha256 ventura:       "4c422bca8f4da8f3472bdb4c3f046bc5da0551bea56f1253e595077bf9350b84"
    sha256 x86_64_linux:  "d499b92233893251bc9f3f4409eee48ce209ad30cb0d1138d9fadacce5571db8"
  end

  depends_on "cmake" => :build
  depends_on "gobject-introspection" => :build
  depends_on "pkgconf" => :build

  depends_on "cairo"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "gettext"
  depends_on "glib"
  depends_on "gpgme"
  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "little-cms2"
  depends_on "nspr"
  depends_on "nss"
  depends_on "openjpeg"

  uses_from_macos "gperf" => :build
  uses_from_macos "curl", since: :monterey # 7.68.0 required by poppler as of https://gitlab.freedesktop.org/poppler/poppler/-/commit/8646a6aa2cb60644b56dc6e6e3b3af30ba920245
  uses_from_macos "zlib"

  on_macos do
    depends_on "libassuan"
  end

  conflicts_with "pdftohtml", "pdf2image", "xpdf",
    because: "poppler, pdftohtml, pdf2image, and xpdf install conflicting executables"

  resource "font-data" do
    url "https://poppler.freedesktop.org/poppler-data-0.4.12.tar.gz"
    sha256 "c835b640a40ce357e1b83666aabd95edffa24ddddd49b8daff63adb851cdab74"
  end

  def install
    ENV.cxx11

    # removes /usr/include from CFLAGS (not clear why)
    ENV["PKG_CONFIG_SYSTEM_INCLUDE_PATH"] = "/usr/include" if OS.mac? && MacOS.version < :mojave

    args = std_cmake_args + %W[
      -DBUILD_GTK_TESTS=OFF
      -DENABLE_BOOST=OFF
      -DENABLE_CMS=lcms2
      -DENABLE_GLIB=ON
      -DENABLE_QT5=OFF
      -DENABLE_QT6=OFF
      -DENABLE_UNSTABLE_API_ABI_HEADERS=ON
      -DWITH_GObjectIntrospection=ON
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]

    system "cmake", "-S", ".", "-B", "build_shared", *args
    system "cmake", "--build", "build_shared"
    system "cmake", "--install", "build_shared"

    system "cmake", "-S", ".", "-B", "build_static", *args, "-DBUILD_SHARED_LIBS=OFF"
    system "cmake", "--build", "build_static"
    lib.install "build_static/libpoppler.a"
    lib.install "build_static/cpp/libpoppler-cpp.a"
    lib.install "build_static/glib/libpoppler-glib.a"

    resource("font-data").stage do
      system "make", "install", "prefix=#{prefix}"
    end
  end

  test do
    system bin/"pdfinfo", test_fixtures("test.pdf")
  end
end
