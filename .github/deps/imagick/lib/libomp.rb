class Libomp < Formula
  desc "LLVM's OpenMP runtime library"
  homepage "https://openmp.llvm.org/"
  url "https://github.com/llvm/llvm-project/releases/download/llvmorg-19.1.5/openmp-19.1.5.src.tar.xz"
  sha256 "ce22e4ff876021071b7eee3fc1be759269a120ac77247265e4bb5150909a36e9"
  license "MIT"

  livecheck do
    url :stable
    regex(/^llvmorg[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "8f18871b507c7b3f552e6fd51c7c6e8250271813387b123205c04e470970cff5"
    sha256 cellar: :any,                 arm64_sonoma:  "599340bb0348194a15e5999cea9db4c1dfbaa571350c2895f7a1c8a7226f1551"
    sha256 cellar: :any,                 arm64_ventura: "86843f4128594a886ddbc13e7bc8bf235bf4f73baec708643f14503184838aa9"
    sha256 cellar: :any,                 sonoma:        "0938823ddef606ebeb3d692216272ff97b983e0668150a6409f6bfd70f84f4b1"
    sha256 cellar: :any,                 ventura:       "5a44204e6ce730cc6fa7008ce743a06abc4407e7cd17257060d8838c0cf14c64"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "692347ec7efb784ce6e29f909639d88f163314ad49cf7061b155770b1b509bdb"
  end

  # Ref: https://github.com/Homebrew/homebrew-core/issues/112107
  keg_only "it can override GCC headers and result in broken builds"

  depends_on "cmake" => :build
  depends_on "lit" => :build
  uses_from_macos "llvm" => :build

  on_linux do
    depends_on "python@3.13"
  end

  resource "cmake" do
    url "https://github.com/llvm/llvm-project/releases/download/llvmorg-19.1.5/cmake-19.1.5.src.tar.xz"
    sha256 "a08ae477571fd5e929c27d3d0d28c6168d58dd00b6354c2de3266ae0d86ad44f"
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
    (testpath/"test.cpp").write <<~CPP
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
    CPP
    system ENV.cxx, "-Werror", "-Xpreprocessor", "-fopenmp", "test.cpp", "-std=c++11",
                    "-I#{include}", "-L#{lib}", "-lomp", "-o", "test"
    system "./test"
  end
end
