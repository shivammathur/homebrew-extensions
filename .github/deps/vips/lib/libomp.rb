class Libomp < Formula
  desc "LLVM's OpenMP runtime library"
  homepage "https://openmp.llvm.org/"
  url "https://github.com/llvm/llvm-project/releases/download/llvmorg-18.1.3/openmp-18.1.3.src.tar.xz"
  sha256 "34f8528575c0916a1ef521afaadba0455a3e49822e8bbbbea9344ab61adeb945"
  license "MIT"

  livecheck do
    url :stable
    regex(/^llvmorg[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "c5fe36d638cbcdd9078adcce371e48957e5df5a41d4ccc5fe50a3e894fdd24ce"
    sha256 cellar: :any,                 arm64_ventura:  "6a69f4e870264a34e6177a3f2ec92edc1d532b0bf30ac189dc7fe2bd596c7dee"
    sha256 cellar: :any,                 arm64_monterey: "2734ad356dd0f8b3b99d9af4980582f18a5e7103e44d64ea454c6fd50b5c26b8"
    sha256 cellar: :any,                 sonoma:         "cf1172c65f3166490542c3ab68d06263808d7c65a51b6fd46e81f41c1f644290"
    sha256 cellar: :any,                 ventura:        "cb9271fe1376e87b8fcc33d0e8302b63ce8c36a96831512e38b8db71d1785a86"
    sha256 cellar: :any,                 monterey:       "d74677bb60effa6b254e1af51f27a6ca40304b1d0f24903c47f12be9cc0d3fb0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1a12343705187df80c7ef24dedef6b499fd079c5b724b81303dc5558dc398bde"
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
    url "https://github.com/llvm/llvm-project/releases/download/llvmorg-18.1.3/cmake-18.1.3.src.tar.xz"
    sha256 "acfecb615d41c5b1a0a31e15324994ca06f7a3f37d8958d719b20de0d217b71b"
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
