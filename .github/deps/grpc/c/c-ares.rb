class CAres < Formula
  desc "Asynchronous DNS library"
  homepage "https://c-ares.org/"
  url "https://c-ares.org/download/c-ares-1.28.0.tar.gz"
  mirror "https://github.com/c-ares/c-ares/releases/download/cares-1_17_2/c-ares-1.28.0.tar.gz"
  mirror "http://fresh-center.net/linux/misc/dns/c-ares-1.28.0.tar.gz"
  mirror "http://fresh-center.net/linux/misc/dns/legacy/c-ares-1.28.0.tar.gz"
  sha256 "3c92febbdebdfe9dea0e037083f55357745e0df34243f9660eed8757db617430"
  license "MIT"
  head "https://github.com/c-ares/c-ares.git", branch: "main"

  livecheck do
    url :homepage
    regex(/href=.*?c-ares[._-](\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "c59b3d87d052c577ff3995ce0bedde455c19ffe3af8be0204d948a12c515e199"
    sha256 cellar: :any,                 arm64_ventura:  "471ea154a9005a788314061ddaa3f2d5e9b19ce0e9531d18aa1b0ca5eaea6e62"
    sha256 cellar: :any,                 arm64_monterey: "8e7d9160ddb98938e72ebbd5668c7836d68ee78556d787d789c055dd90649dfa"
    sha256 cellar: :any,                 sonoma:         "944f8f2d89e0bffec83a407fae20eeeb9f61d2fd5c42f87e745d1c58596ed972"
    sha256 cellar: :any,                 ventura:        "29488e679b074e894e607136865a6690c58f1b02736d8e50695f668d1a97885b"
    sha256 cellar: :any,                 monterey:       "732b07978346a3a4dbf9ccdc420c9a4b917db76847b592467eed74392153789b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b513128810bf537019d9a938e8a4fec32cae1e653d15538b97f2d6ac60d26393"
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

    system "#{bin}/ahost", "127.0.0.1"
  end
end
