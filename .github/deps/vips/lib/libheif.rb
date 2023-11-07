class Libheif < Formula
  desc "ISO/IEC 23008-12:2017 HEIF file format decoder and encoder"
  homepage "https://www.libde265.org/"
  url "https://github.com/strukturag/libheif/releases/download/v1.17.3/libheif-1.17.3.tar.gz"
  sha256 "8d5b6292e7931324f81f871f250ecbb9f874aa3c66b4f6f35ceb0bf3163b53ea"
  license "LGPL-3.0-only"

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "71c135396b5665ab416316e3fdd2b4909aa07236f7856fce83e018765db7da92"
    sha256 cellar: :any,                 arm64_ventura:  "9243397c900632011a439cf675d44ec6df9fb1ef7efc3369aeb9ac8f4990bc64"
    sha256 cellar: :any,                 arm64_monterey: "605416dab36f19287656d7f9107865c13ca95fc41f6466e3a78aceff4cc72b93"
    sha256 cellar: :any,                 sonoma:         "68b8a70f61eaa45ac55a2819fc5dceced297532510d296bbd58dcfa2cf587f15"
    sha256 cellar: :any,                 ventura:        "f58a700a9f1b525dff6e3a6d575b2283ef5bd1b015a565050591e8faaa57624c"
    sha256 cellar: :any,                 monterey:       "1af72840dcb3f1eaa309ee89ef4b7711900300dc8f4f3c53e2f18f3f887ee9fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1c9b77650ecb87747239e486374800940ca6f3ed8251641a01dc37ddb77824b4"
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "aom"
  depends_on "jpeg-turbo"
  depends_on "libde265"
  depends_on "libpng"
  depends_on "shared-mime-info"
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
