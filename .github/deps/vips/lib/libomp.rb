class Libomp < Formula
  desc "LLVM's OpenMP runtime library"
  homepage "https://openmp.llvm.org/"
  url "https://github.com/llvm/llvm-project/releases/download/llvmorg-19.1.3/openmp-19.1.3.src.tar.xz"
  sha256 "6c671756d7412bbf0085e7deffc7e8b4ac34955b33dce76c526795df1e9b48a7"
  license "MIT"

  livecheck do
    url :stable
    regex(/^llvmorg[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "ca0c84e23b472d6546fc5de743a24ebcb47eaa19582aeabd53599a088f3062c2"
    sha256 cellar: :any,                 arm64_sonoma:  "64af3652b6b00d492da937bf12a8f39479f2daf2d4252f31535ffd21e029cad4"
    sha256 cellar: :any,                 arm64_ventura: "c690f315ca2475e17ce53cbedbd3ba716c22b8c8e1e88d310950ecd7873bc8ed"
    sha256 cellar: :any,                 sonoma:        "d073839cd9010e959bef54b522f966f5575860a19645dabf60ccedb4079dc24d"
    sha256 cellar: :any,                 ventura:       "ad1d3723e511ec080f60f99348bd8c9368cb04d58334941a53886dbdcfd2267f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8ead5e243eb721f8d0815ab480a36747f165fcc4529bdf25718d16668f885658"
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
    url "https://github.com/llvm/llvm-project/releases/download/llvmorg-19.1.3/cmake-19.1.3.src.tar.xz"
    sha256 "4c55aa6e77fc0e8b759bca2c79ee4fd0ea8c7fab06eeea09310ae1e954a0af5e"
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
