class Libomp < Formula
  desc "LLVM's OpenMP runtime library"
  homepage "https://openmp.llvm.org/"
  url "https://github.com/llvm/llvm-project/releases/download/llvmorg-16.0.4/openmp-16.0.4.src.tar.xz"
  sha256 "7e88b67dc53f24bfacc58782e756ae34458261fe6d2820173454debb56ab26e4"
  license "MIT"

  livecheck do
    url :stable
    regex(/^llvmorg[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "31bf8355653555ddbb459a206539c98f87296880b107c88f650bf7c7163d4a65"
    sha256 cellar: :any,                 arm64_monterey: "2d03aa78eb422783de7d322086940f8e731b33338ffd7b06c9863af2d17f6563"
    sha256 cellar: :any,                 arm64_big_sur:  "4101459fe3ba90c87db103f68973377226b9be6f780fe720d05c0e9d9feb0ed2"
    sha256 cellar: :any,                 ventura:        "9263ad8503bb512f0172d894202be782a53697d93690a3348424890d58a1b2b7"
    sha256 cellar: :any,                 monterey:       "9526f8af28ba720b2cb7a629707d566e33dd4320083863683907b37967647c97"
    sha256 cellar: :any,                 big_sur:        "545954b6295e386283985bbf2810492bbdb55b395ea2d52e83fa6050075fcf32"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5a48b569d241dd2e36e84857c19c31534a39b630f9bc38ed9940e958ff2a7bc6"
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
    url "https://github.com/llvm/llvm-project/releases/download/llvmorg-16.0.4/cmake-16.0.4.src.tar.xz"
    sha256 "1a366c5f7a7a0efa2f7ede960717f26f5332df28adc9b3c47516a859de2ccf7b"
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
