class CAres < Formula
  desc "Asynchronous DNS library"
  homepage "https://c-ares.org/"
  url "https://c-ares.org/download/c-ares-1.23.0.tar.gz"
  mirror "https://github.com/c-ares/c-ares/releases/download/cares-1_17_2/c-ares-1.23.0.tar.gz"
  mirror "http://fresh-center.net/linux/misc/dns/c-ares-1.23.0.tar.gz"
  mirror "http://fresh-center.net/linux/misc/dns/legacy/c-ares-1.23.0.tar.gz"
  sha256 "cb614ecf78b477d35963ebffcf486fc9d55cc3d3216f00700e71b7d4868f79f5"
  license "MIT"
  head "https://github.com/c-ares/c-ares.git", branch: "main"

  livecheck do
    url :homepage
    regex(/href=.*?c-ares[._-](\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "e9f95be6725d5e210fdf2d590cd0112df3654815d24a0aaff28ae14794a7c98c"
    sha256 cellar: :any,                 arm64_ventura:  "f4d0de11e8d6e5866b9e9b3d4b4cb9fef935e5f9aedd8c974618b61712754cd0"
    sha256 cellar: :any,                 arm64_monterey: "c30c928efaaff5bd838f960ba472a823a9cb3496325a95a1f02ea1ff893eb983"
    sha256 cellar: :any,                 sonoma:         "9f4b1d48de67b5df13c9824460519eeefd2335dfb1abe1f23d21fdae60fed50a"
    sha256 cellar: :any,                 ventura:        "49a244389c56ec7608ff80daba29516168a406d7b5bbb83f4e9b9ac7c66bd983"
    sha256 cellar: :any,                 monterey:       "36f5b3f8c718f1374f6449c4eabd78ff3dd6846150feeb86422261d410d11622"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8f5b82056bc0c47fe33bdb55062c01fb7f8a36b40cfdc5d8352b8e9f329023a7"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DCMAKE_INSTALL_RPATH=#{rpath}"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include <ares.h>

      int main()
      {
        ares_library_init(ARES_LIB_INIT_ALL);
        ares_library_cleanup();
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lcares", "-o", "test"
    system "./test"

    system "#{bin}/ahost", "127.0.0.1"
  end
end
