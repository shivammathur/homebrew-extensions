class CAres < Formula
  desc "Asynchronous DNS library"
  homepage "https://c-ares.org/"
  url "https://github.com/c-ares/c-ares/releases/download/v1.34.3/c-ares-1.34.3.tar.gz"
  sha256 "26e1f7771da23e42a18fdf1e58912a396629e53a2ac71b130af93bbcfb90adbe"
  license "MIT"
  head "https://github.com/c-ares/c-ares.git", branch: "main"

  livecheck do
    url :homepage
    regex(/href=.*?c-ares[._-](\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "e0a8f161010f3f7ea690a32812121acf1fe2fd5f9f61dee32ed19fbe9677222a"
    sha256 cellar: :any,                 arm64_sonoma:  "5433ae54213bd83e5832581a25ffc63c2fa977accf4501ef3126c2766454c28e"
    sha256 cellar: :any,                 arm64_ventura: "8b60282b8775785b865d51c4916081e98b30bb74edd8c83807974fe89de2e59b"
    sha256 cellar: :any,                 sonoma:        "1e05842f0ed0d461ad12df47938ffbdeb1061d19b52224b5bdfed4739caeeb52"
    sha256 cellar: :any,                 ventura:       "02da84df0a0f3c1a5a7e8a539d25b0da0a6a022c77447d396512034a55b52797"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ad86ef643c7f3253ac301f868c7dcb13a5421decabcf146944d812179b7e2637"
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
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <ares.h>

      int main()
      {
        ares_library_init(ARES_LIB_INIT_ALL);
        ares_library_cleanup();
        return 0;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-lcares", "-o", "test"
    system "./test"

    system bin/"ahost", "127.0.0.1"
  end
end
