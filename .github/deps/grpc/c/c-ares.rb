class CAres < Formula
  desc "Asynchronous DNS library"
  homepage "https://c-ares.org/"
  url "https://github.com/c-ares/c-ares/releases/download/v1.32.3/c-ares-1.32.3.tar.gz"
  sha256 "5f02cc809aac3f6cc5edc1fac6c4423fd5616d7406ce47b904c24adf0ff2cd0f"
  license "MIT"
  head "https://github.com/c-ares/c-ares.git", branch: "main"

  livecheck do
    url :homepage
    regex(/href=.*?c-ares[._-](\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "d869b3da1658f9568f609268a18713b3369428c95977529fc799ef8492f29e80"
    sha256 cellar: :any,                 arm64_ventura:  "49b505a860bb0aaa0c62335b94070a6247d09d12e0678275aa13b402ad8810aa"
    sha256 cellar: :any,                 arm64_monterey: "55018dd7bff0f0782988c2b0843584a8d1819e09c51a7e99440cbc2c98fb8157"
    sha256 cellar: :any,                 sonoma:         "9d050e08461da87d04c50346ea3f0adb437066cf4c686801a732882cafefb897"
    sha256 cellar: :any,                 ventura:        "4e6c2ab0fc49387630db9b37d3c621b0d55403c6f35fef10c3f97118fa0976a4"
    sha256 cellar: :any,                 monterey:       "7a7db88271dedde877737195f19c899f74576bc315e18a5d066ddf4d5bdcc66d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9a7d416ce1316f44e62b3598b008059a6e97074e7745bd2735946671c1961191"
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
