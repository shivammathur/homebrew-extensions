class Libheif < Formula
  desc "ISO/IEC 23008-12:2017 HEIF file format decoder and encoder"
  homepage "https://www.libde265.org/"
  url "https://github.com/strukturag/libheif/releases/download/v1.19.1/libheif-1.19.1.tar.gz"
  sha256 "994913eb2a29c00c146d6f3d61e07d9ff0d8e9eccb0624d87e4be8b108c74e4b"
  license "LGPL-3.0-only"

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "8beeb83c567e7a81205a62f649bbced77011944b1b7fc6bfa038e4a8faae55ba"
    sha256 cellar: :any,                 arm64_sonoma:  "c7ebcafb946eb57721b21b30574098ab7aff36577c7b72068479ac7e4e83b4e3"
    sha256 cellar: :any,                 arm64_ventura: "c18dfa7ee1f29480b58068c799d1aa056343e14695025d5cb1f27059cb586a00"
    sha256 cellar: :any,                 sonoma:        "ac23561111d4beef1488df9f888a9b991607f85ee43fa6a92f02f603b212f5e6"
    sha256 cellar: :any,                 ventura:       "75cd8aad87f8b7f79d10f34031b96872b34b474dba3233ae09336303fd553641"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "947d413b06ef2874a50e0d8d1962287be98e672dd9416dd75875087b426c88cd"
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  depends_on "aom"
  depends_on "jpeg-turbo"
  depends_on "libde265"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "shared-mime-info"
  depends_on "webp"
  depends_on "x265"

  def install
    args = %W[
      -DCMAKE_INSTALL_RPATH=#{rpath}
      -DWITH_DAV1D=OFF
      -DWITH_GDK_PIXBUF=OFF
      -DWITH_RAV1E=OFF
      -DWITH_SvtEnc=OFF
    ]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    pkgshare.install "examples/example.heic"
    pkgshare.install "examples/example.avif"

    # In order to avoid duplicated symbol error when build static library
    inreplace "examples/heif_info.cc", "fourcc_to_string", "example_fourcc_to_string"

    system "cmake", "-S", ".", "-B", "static", *args, *std_cmake_args, "-DBUILD_SHARED_LIBS=OFF"
    system "cmake", "--build", "static"
    lib.install "static/libheif/libheif.a"
  end

  def post_install
    system Formula["shared-mime-info"].opt_bin/"update-mime-database", "#{HOMEBREW_PREFIX}/share/mime"
  end

  test do
    output = "File contains 2 images"
    example = pkgshare/"example.heic"
    exout = testpath/"exampleheic.jpg"

    assert_match output, shell_output("#{bin}/heif-convert #{example} #{exout}")
    assert_predicate testpath/"exampleheic-1.jpg", :exist?
    assert_predicate testpath/"exampleheic-2.jpg", :exist?

    output = "File contains 1 image"
    example = pkgshare/"example.avif"
    exout = testpath/"exampleavif.jpg"

    assert_match output, shell_output("#{bin}/heif-convert #{example} #{exout}")
    assert_predicate testpath/"exampleavif.jpg", :exist?
  end
end
