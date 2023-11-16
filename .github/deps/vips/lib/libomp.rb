class Libomp < Formula
  desc "LLVM's OpenMP runtime library"
  homepage "https://openmp.llvm.org/"
  url "https://github.com/llvm/llvm-project/releases/download/llvmorg-17.0.5/openmp-17.0.5.src.tar.xz"
  sha256 "13c80e80d3eea2f4ffe89585a8e8c81bdedec410192c613fc089a12f7da4c0a2"
  license "MIT"

  livecheck do
    url :stable
    regex(/^llvmorg[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "6fe8812b221d644365aefbd734de279181e4718ad536869fb400ab602014293d"
    sha256 cellar: :any,                 arm64_ventura:  "58f55ccd2d5561c50f1d4ee133fa39ae3a999fce7bd00b22ca640368a65a3bf5"
    sha256 cellar: :any,                 arm64_monterey: "cfd27330761cb958d39ef9e12bafe263fbfcf819b00cea86f7fda11a2275d34a"
    sha256 cellar: :any,                 sonoma:         "1c233630c58c7eb2666ea17edac8985639fe90de5520e89d529a09405e7b46cb"
    sha256 cellar: :any,                 ventura:        "55bc3e3a99cc656cff2f21844594b081c8e8584825a8b638ab1b5585e193f513"
    sha256 cellar: :any,                 monterey:       "fa67cd6b320cd521606fd0fa19a915e3eb6e4a0c93670d5201d5f4a49f84f2f4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "43ec8073805707c12c37a2d2714dba5dbc77dc3c9b2dd2ba6dbb9e1de2eed55a"
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
    url "https://github.com/llvm/llvm-project/releases/download/llvmorg-17.0.5/cmake-17.0.5.src.tar.xz"
    sha256 "734ea7767ebda642d22c878024c9fb14ae0521d048bdba54e463bb73260adaef"
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
