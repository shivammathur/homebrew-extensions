class Libomp < Formula
  desc "LLVM's OpenMP runtime library"
  homepage "https://openmp.llvm.org/"
  url "https://github.com/llvm/llvm-project/releases/download/llvmorg-19.1.4/openmp-19.1.4.src.tar.xz"
  sha256 "88359996537b0fe7191869f7a1ec8b5a0e7e284294c09202965efcce1e571ccb"
  license "MIT"

  livecheck do
    url :stable
    regex(/^llvmorg[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "047ed36b7e63e2bfaf92dffd950bb3b0f824c4211a51e77742ef5aa1e40ce14e"
    sha256 cellar: :any,                 arm64_sonoma:  "bd0896c575b44543930fec1fb3977c6b8c9ce87db2cf0b5500a3590360c92afa"
    sha256 cellar: :any,                 arm64_ventura: "3451343ad73a9b7d133e87583cf234ab21c12443660677b8c0884fa5924a4ee8"
    sha256 cellar: :any,                 sonoma:        "1f286dd64b954c6b1cf4311fbe08241a52ae6c3425bcae86a86618fad72bc626"
    sha256 cellar: :any,                 ventura:       "f21863c5b10174df0a9716cf3b11744c7c6c533aeb9128f4fae37c2bfecee429"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1a6495e7999a058ce59781b88a02165675ddbed1cefea93cdf004bdd4cc56859"
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
    url "https://github.com/llvm/llvm-project/releases/download/llvmorg-19.1.4/cmake-19.1.4.src.tar.xz"
    sha256 "dd13ce8eba6ece85cad567f028b8e16d72f3e142cdcbbd693ac23a88b4013803"
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
