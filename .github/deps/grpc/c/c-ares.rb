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
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "a2659a49b749fa30972d68042f23ae8500eb2ef470b39d4d7c1d006b0d631192"
    sha256 cellar: :any,                 arm64_ventura:  "6afea5fb4e5ff029cc3f68c6523458f7f4d800d1e20e1f7617d776c77c203e22"
    sha256 cellar: :any,                 arm64_monterey: "52797daa8054095bf4d4c8d0f3bdce6b41a5ae4d5f6e34ac8c2d09851ca6c187"
    sha256 cellar: :any,                 sonoma:         "eb6e1e08bc53b05cdbdcb64b6b494646b93cec6650e58182b80a22dfcee72c7d"
    sha256 cellar: :any,                 ventura:        "7a5d3e35412af7e9f924ae2314579bb47874f5c1183a43cdcd955c92ac3065aa"
    sha256 cellar: :any,                 monterey:       "5d56fbdc7854b40681bc7d76cbeb463d2d15524b0ea646d4ea169cd27e8a99b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "59015edadad722031a2b46a0791c728b3453015c1c217175cf22c41ea12ddf5c"
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
