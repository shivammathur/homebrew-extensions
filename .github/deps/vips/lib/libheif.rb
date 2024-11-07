class Libheif < Formula
  desc "ISO/IEC 23008-12:2017 HEIF file format decoder and encoder"
  homepage "https://www.libde265.org/"
  url "https://github.com/strukturag/libheif/releases/download/v1.19.2/libheif-1.19.2.tar.gz"
  sha256 "f73eb786e75ef1f815ed3d37aca9eadd41dc1d26dfde11f8a4f92f911622d19e"
  license "LGPL-3.0-only"

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "0a5ad4df9f462b5c9d22a6a6cfc44e5c4651d2259c7e1338fc3ca01f48006209"
    sha256 cellar: :any,                 arm64_sonoma:  "330cb73eb691eb4f29ade318eef836cdaac55b721412216bb0224fd54e8fe951"
    sha256 cellar: :any,                 arm64_ventura: "edffd6e1d566686da0f58408936236f0bb77d8645327c694940a52f884187148"
    sha256 cellar: :any,                 sonoma:        "3571171fa732956fca7310beb740276cca5142ca63fbdb002756e0a2794b5066"
    sha256 cellar: :any,                 ventura:       "6bb98d90781d18072179d2e3737ab31db51097dab85a5b3b5c70bd43e1f4bfb3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6fccf3ad6c45fc538ae62cc2a87aa73110ebad794917770cb381c72a3535e9b1"
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
