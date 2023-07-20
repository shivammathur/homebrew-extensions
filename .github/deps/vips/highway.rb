class Highway < Formula
  desc "Performance-portable, length-agnostic SIMD with runtime dispatch"
  homepage "https://github.com/google/highway"
  url "https://github.com/google/highway/archive/refs/tags/1.0.5.tar.gz"
  sha256 "99b7dad98b8fa088673b720151458fae698ae5df9154016e39de4afdc23bb927"
  license "Apache-2.0"
  head "https://github.com/google/highway.git", branch: "master"

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "239c140355c53a1422a0ef852a9238e8f72e9c3e27c3bb57df064b7163390f92"
    sha256 cellar: :any,                 arm64_monterey: "8e5efad2257f1e9c04fa10cbb8c9db5d45e67a36bd04d8f6db57db1f0030c73d"
    sha256 cellar: :any,                 arm64_big_sur:  "e6ddd282e90a6a8ca33f0e9f6ecd78f29aca73dd8ff083a2153c450a1bdbdab9"
    sha256 cellar: :any,                 ventura:        "6e797db3891fb898176b5e7b7ec495e1d616beddf59a23552d91c7be5b887690"
    sha256 cellar: :any,                 monterey:       "da66c4f49d6877ac71409b6deec4bac9bbaccf03b1c0a24d4b504f3b6a76c37b"
    sha256 cellar: :any,                 big_sur:        "26b0f0f234baf901f01d5a569e8cc6814c1478341ff396f578768db09d464f4e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "305d95f45a759ac1461ad14e95379165007ef3c436d801b653c93248ab587ad1"
  end

  depends_on "cmake" => :build

  # These used to be bundled with `jpeg-xl`.
  link_overwrite "include/hwy/*", "lib/pkgconfig/libhwy*"

  def install
    ENV.runtime_cpu_detection
    system "cmake", "-S", ".", "-B", "builddir",
                    "-DBUILD_SHARED_LIBS=ON",
                    "-DHWY_ENABLE_TESTS=OFF",
                    "-DHWY_ENABLE_EXAMPLES=OFF",
                    "-DCMAKE_INSTALL_RPATH=#{rpath}",
                    *std_cmake_args
    system "cmake", "--build", "builddir"
    system "cmake", "--install", "builddir"
    (share/"hwy").install "hwy/examples"
  end

  test do
    system ENV.cxx, "-std=c++11", "-I#{share}", "-I#{include}",
                    share/"hwy/examples/benchmark.cc", "-L#{lib}", "-lhwy"
    system "./a.out"
  end
end
