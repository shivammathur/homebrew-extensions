class CAres < Formula
  desc "Asynchronous DNS library"
  homepage "https://c-ares.org/"
  url "https://github.com/c-ares/c-ares/releases/download/v1.32.0/c-ares-1.32.0.tar.gz"
  sha256 "5ab3fad06edb98fe8081febe1e41a027cfa3199fc525a59c851376414fe24c5b"
  license "MIT"
  head "https://github.com/c-ares/c-ares.git", branch: "main"

  livecheck do
    url :homepage
    regex(/href=.*?c-ares[._-](\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "4e04d7f17bb91ebb2200b23904105c33f53d9e61e9b471c9d7e022e953dba7e2"
    sha256 cellar: :any,                 arm64_ventura:  "063d98d3be6485cd6f9da8b91dea7acb4ec47a9de02f54a7f52a58eb9b95021e"
    sha256 cellar: :any,                 arm64_monterey: "90fcf496ae3a603c1eb64c7a6041f7a4b8a628c1684b9de2ee8021558156e3b4"
    sha256 cellar: :any,                 sonoma:         "1058bd8a9b0a46e334f3daa8165484d4b40cbcb241adc7f887444b16bbf6514a"
    sha256 cellar: :any,                 ventura:        "77d675c961626b49466d09336c495396a481b42dcf1d1559c43af8ff1a7d54b1"
    sha256 cellar: :any,                 monterey:       "9f8843bb47d9d3e2ef6d7cdf0a9883fa91a4f7bb1647d7814bb2858445e0f0aa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2bf99f53c86a90a9210ebc293964914482825aa888dd08813542c7e8b08398d7"
  end

  depends_on "cmake" => :build

  def install
    args = %W[
      -DCARES_STATIC=ON
      -DCARES_SHARED=ON
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
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

    system bin/"ahost", "127.0.0.1"
  end
end
