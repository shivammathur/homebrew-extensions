class Libomp < Formula
  desc "LLVM's OpenMP runtime library"
  homepage "https://openmp.llvm.org/"
  url "https://github.com/llvm/llvm-project/releases/download/llvmorg-16.0.3/openmp-16.0.3.src.tar.xz"
  sha256 "6ff2bb78c95d9b430203dcba50e41433e1f72696af7b2196c8056ac4bc9f2516"
  license "MIT"

  livecheck do
    url :stable
    regex(/^llvmorg[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "c8053a130de5c0ab042e4f7dc1280741b747ed263760ba6d3866d909442c2d79"
    sha256 cellar: :any,                 arm64_monterey: "320ddf2391b911973137442ca5efff2b68d04124684ed97187d3668d75549d5a"
    sha256 cellar: :any,                 arm64_big_sur:  "e3e3e992700e268ecb9f0bd4ee470753d06a7f0544570ca541a83b32023cc0ce"
    sha256 cellar: :any,                 ventura:        "fae831421301732aec85a00d3fe4110343ff356d06d87e7b4b15cce9eb5f09e1"
    sha256 cellar: :any,                 monterey:       "d4d29c115f389d0848e972feb45a7d9533c35212926a2ee0c04367758c49ad5a"
    sha256 cellar: :any,                 big_sur:        "8ca05fa2583fc78db440d63e426675d0fe3635e2efa8b6811aeb7c4c36939f36"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "422eea07a5eb3cedb9746072ec49b8bea2a07804680367f3cf916c05766f1ed9"
  end

  # Ref: https://github.com/Homebrew/homebrew-core/issues/112107
  keg_only "it can override GCC headers and result in broken builds"

  depends_on "cmake" => :build
  depends_on "lit" => :build
  uses_from_macos "llvm" => :build

  on_linux do
    depends_on "python@3.11"
  end

  resource "cmake" do
    url "https://github.com/llvm/llvm-project/releases/download/llvmorg-16.0.3/cmake-16.0.3.src.tar.xz"
    sha256 "b6d83c91f12757030d8361dedc5dd84357b3edb8da406b5d0850df8b6f7798b1"
  end

  def install
    (buildpath/"src").install buildpath.children
    (buildpath/"cmake").install resource("cmake")

    # Disable LIBOMP_INSTALL_ALIASES, otherwise the library is installed as
    # libgomp alias which can conflict with GCC's libgomp.
    args = ["-DLIBOMP_INSTALL_ALIASES=OFF"]
    args << "-DOPENMP_ENABLE_LIBOMPTARGET=OFF" if OS.linux?

    system "cmake", "-S", "src", "-B", "build/shared", *std_cmake_args, *args
    system "cmake", "--build", "build/shared"
    system "cmake", "--install", "build/shared"

    system "cmake", "-S", "src", "-B", "build/static",
                    "-DLIBOMP_ENABLE_SHARED=OFF",
                    *std_cmake_args, *args
    system "cmake", "--build", "build/static"
    system "cmake", "--install", "build/static"
  end

  test do
    assert_equal version, resource("cmake").version, "`cmake` resource needs updating!"
    (testpath/"test.cpp").write <<~EOS
      #include <omp.h>
      #include <array>
      int main (int argc, char** argv) {
        std::array<size_t,2> arr = {0,0};
        #pragma omp parallel num_threads(2)
        {
            size_t tid = omp_get_thread_num();
            arr.at(tid) = tid + 1;
        }
        if(arr.at(0) == 1 && arr.at(1) == 2)
            return 0;
        else
            return 1;
      }
    EOS
    system ENV.cxx, "-Werror", "-Xpreprocessor", "-fopenmp", "test.cpp", "-std=c++11",
                    "-I#{include}", "-L#{lib}", "-lomp", "-o", "test"
    system "./test"
  end
end
