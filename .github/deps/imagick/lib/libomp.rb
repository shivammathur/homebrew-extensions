class Libomp < Formula
  desc "LLVM's OpenMP runtime library"
  homepage "https://openmp.llvm.org/"
  url "https://github.com/llvm/llvm-project/releases/download/llvmorg-19.1.0/openmp-19.1.0.src.tar.xz"
  sha256 "c036fd95c8eeea8d7bce4196ee20cc5c5a99702d6ec7f0bb19828e315bc3a9ac"
  license "MIT"

  livecheck do
    url :stable
    regex(/^llvmorg[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "10fff6a51536b7ae65426186c2fc14032bd39ed3ff0677d98a6c0cdabb5d805c"
    sha256 cellar: :any,                 arm64_sonoma:  "e1af2969f3d0449130024e67d95219be0778a4b4260f84e06629bdd89181e129"
    sha256 cellar: :any,                 arm64_ventura: "0bec68ab533c34535d46af20943a11e160bf1b12ae7705388478cad0ee9d74a9"
    sha256 cellar: :any,                 sonoma:        "7cb7f285e2a2742fba639781bfa876a0bd157d16afd0867f37db1b0db71abaa7"
    sha256 cellar: :any,                 ventura:       "3f7f4cd61dc591795dcc41a9eab15bf7c3d1c5c2af8ce051b128b75cbde1d70a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8b77c0dd9707c2ed6e9bb4a4199e23fcefda29c2dc9c4e4ec5bf244f3add21b2"
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
    url "https://github.com/llvm/llvm-project/releases/download/llvmorg-19.1.0/cmake-19.1.0.src.tar.xz"
    sha256 "dc78b6a9ac8a097ca6ac0f23c06821d65e6ea3bf666026f529994c1d01056ae7"
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
