class Libomp < Formula
  desc "LLVM's OpenMP runtime library"
  homepage "https://openmp.llvm.org/"
  url "https://github.com/llvm/llvm-project/releases/download/llvmorg-19.1.6/openmp-19.1.6.src.tar.xz"
  sha256 "549294ef37e2c9ec8317258b539e56f25d479ed811e2db846017e028b69f8da6"
  license "MIT"

  livecheck do
    url :stable
    regex(/^llvmorg[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "b2a9bbff5316d304ce2a239793bd6df65203f6a990a07df94a0608f394316caa"
    sha256 cellar: :any,                 arm64_sonoma:  "b6aaa5b6a01a8d914d2365b28bb3071200c7e8c59578a93641fb89bfeea365db"
    sha256 cellar: :any,                 arm64_ventura: "c31708d21bdf7d5595b2ab885868f88341ba54fc521cb0d22c8e7635d9132817"
    sha256 cellar: :any,                 sonoma:        "3c6a3a2ffcd4cbdf54daf7707a55dd05e941c063d17a7179d30547ea1139db7c"
    sha256 cellar: :any,                 ventura:       "da7fe7fb4ba54ae897ec44b36d30e6b178561156e87e9996c90d9f7141a567d6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5ba39b27cf71f5bdf90a30a2800d0e79d52e01ee2999d1854cee01e7d462b826"
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
    url "https://github.com/llvm/llvm-project/releases/download/llvmorg-19.1.6/cmake-19.1.6.src.tar.xz"
    sha256 "9c7ec82d9a240dc2287b8de89d6881bb64ceea0dcd6ce133c34ef65bda22d99e"
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
