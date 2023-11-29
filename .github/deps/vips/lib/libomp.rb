class Libomp < Formula
  desc "LLVM's OpenMP runtime library"
  homepage "https://openmp.llvm.org/"
  url "https://github.com/llvm/llvm-project/releases/download/llvmorg-17.0.6/openmp-17.0.6.src.tar.xz"
  sha256 "74334cbb4dc8b73a768448a7561d5a3540404940b2267b1fb9813a6464b320de"
  license "MIT"

  livecheck do
    url :stable
    regex(/^llvmorg[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "f31b264e11426d16cbe38f4410f6be5405dfae9eb53a8ff99a8fb2c73b5b3f71"
    sha256 cellar: :any,                 arm64_ventura:  "5b78eb7312107eba8d91912444d4617dfb76cb95ee68ce837f7c22e51ce5e2a9"
    sha256 cellar: :any,                 arm64_monterey: "1a771c79450cb6d47803e9149b91a6f4aa2dce3dd8929831116cdc06d3a2eb02"
    sha256 cellar: :any,                 sonoma:         "1c8c2254625ca8e941eb2a0cec32e2488bbe16fdd5bd11a025db562496522db4"
    sha256 cellar: :any,                 ventura:        "e2c4a8ad78a67079e7d2bc0b65897ab6404ba1101aed849ac51d7551c33ebf0f"
    sha256 cellar: :any,                 monterey:       "924729203a2dfe1e4ced503e2d266d7780df1d3dd394b2b924746968a5cb211e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d2bbf30d064f8024c5018a9c3126092c67c1361cab3b51c9cefc9c9c688a9a44"
  end

  # Ref: https://github.com/Homebrew/homebrew-core/issues/112107
  keg_only "it can override GCC headers and result in broken builds"

  depends_on "cmake" => :build
  depends_on "lit" => :build
  uses_from_macos "llvm" => :build

  on_linux do
    depends_on "python@3.12"
  end

  resource "cmake" do
    url "https://github.com/llvm/llvm-project/releases/download/llvmorg-17.0.6/cmake-17.0.6.src.tar.xz"
    sha256 "807f069c54dc20cb47b21c1f6acafdd9c649f3ae015609040d6182cab01140f4"
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
