class Libomp < Formula
  desc "LLVM's OpenMP runtime library"
  homepage "https://openmp.llvm.org/"
  url "https://github.com/llvm/llvm-project/releases/download/llvmorg-18.1.6/openmp-18.1.6.src.tar.xz"
  sha256 "24ffd900fc7b707fda3a2d3b4aa011289d5a5fedff19c348dfdc4351f7063aae"
  license "MIT"

  livecheck do
    url :stable
    regex(/^llvmorg[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "a70d0d40688e8aff2129836f502b2b405b41113cab3ebb0c46c5a3ed049513b1"
    sha256 cellar: :any,                 arm64_ventura:  "02ed5c44136c0a3a65b58c0be85e4a337199406ccf3552be2774708c7d096ae8"
    sha256 cellar: :any,                 arm64_monterey: "0e10ddd8baedb5442cb6f8bb1e3600eb201a8e8eff4d11ebfd50d23e5e042c9d"
    sha256 cellar: :any,                 sonoma:         "3235bb62b04ce4b39c64281f3effeaf75d4e64f5ed4129c576c3c7c177d162dc"
    sha256 cellar: :any,                 ventura:        "743c3906dbeaef3bca0de0591d9f37ea1f66ac99142d561e7db91bc935ee5baf"
    sha256 cellar: :any,                 monterey:       "e550c460ed3226b41d0972213de4dc845000e4b537d2e367da2b3636fd38f32e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2097689006f4cb858f76042280b72b2c9ad901e77651826d2310943915250a46"
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
    url "https://github.com/llvm/llvm-project/releases/download/llvmorg-18.1.6/cmake-18.1.6.src.tar.xz"
    sha256 "a643261ed98ff76ab10f1a7039291fa841c292435ba1cfe11e235c2231b95cdb"
  end

  def install
    odie "cmake resource needs to be updated" if version != resource("cmake").version

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
