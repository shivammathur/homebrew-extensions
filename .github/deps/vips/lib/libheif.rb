class Libheif < Formula
  desc "ISO/IEC 23008-12:2017 HEIF file format decoder and encoder"
  homepage "https://www.libde265.org/"
  url "https://github.com/strukturag/libheif/releases/download/v1.18.1/libheif-1.18.1.tar.gz"
  sha256 "8702564b0f288707ea72b260b3bf4ba9bf7abfa7dac01353def3a86acd6bbb76"
  license "LGPL-3.0-only"

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "3be31f533a8fd5294ce84447f6bf0d478c7f9828a6431782c5e74c0932279f29"
    sha256 cellar: :any,                 arm64_ventura:  "f05d0aadf2398e1a5df972d9800a10dee8abe1012b08d6297b4715e21b7c13ed"
    sha256 cellar: :any,                 arm64_monterey: "c7ee53111c07372c6cc7988642322452fb1ebc5fcaf94caf41d81bdcfd8d286f"
    sha256 cellar: :any,                 sonoma:         "20d0209694c2028158e13b5f15df4e902f808f021c0aefcd614ef3420281f129"
    sha256 cellar: :any,                 ventura:        "e14a2a2dfbbfa3b39d143dcb2ee3d634c65242be445d25db3a66bbbb0d94d8a3"
    sha256 cellar: :any,                 monterey:       "f26580925576570ad0b28f4999cc71c10df954797113955571ea590547c72c75"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "136ac32948324f187c0d9a499b6ae3f88cbbfa37f8088d360c0afbc7bfa998af"
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
      -DWITH_RAV1E=OFF
      -DWITH_DAV1D=OFF
      -DWITH_SvtEnc=OFF
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    pkgshare.install "examples/example.heic"
    pkgshare.install "examples/example.avif"
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
