class CAres < Formula
  desc "Asynchronous DNS library"
  homepage "https://c-ares.org/"
  url "https://c-ares.org/download/c-ares-1.21.0.tar.gz"
  mirror "https://github.com/c-ares/c-ares/releases/download/cares-1_17_2/c-ares-1.21.0.tar.gz"
  mirror "http://fresh-center.net/linux/misc/dns/c-ares-1.21.0.tar.gz"
  mirror "http://fresh-center.net/linux/misc/dns/legacy/c-ares-1.21.0.tar.gz"
  sha256 "cd7aa3af1d3ee780d6437039a7ddb7f1ec029f9c4f7aabb0197e384eb5bc2f2d"
  license "MIT"
  head "https://github.com/c-ares/c-ares.git", branch: "main"

  livecheck do
    url :homepage
    regex(/href=.*?c-ares[._-](\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "da2561c1b2cb42a5e68c71ad7bef33c55e21a6cbc8520589935b8e615bf95239"
    sha256 cellar: :any,                 arm64_ventura:  "46f38f2a7e61e5e44fc6108cb0778c5a71e2578cc091557f71c2d81527fe118a"
    sha256 cellar: :any,                 arm64_monterey: "81f30cb5e46c6ea7c30c4fedb2c42fb14d9d206e5b9e41c5f4316e5946fd59a4"
    sha256 cellar: :any,                 sonoma:         "62d6a76be82aaa4eb8dc97d8675ae44a5ba51ab7f3b87f225b4d3aaffb66c66e"
    sha256 cellar: :any,                 ventura:        "8fc8b42a538c34a7549f9dcf34673007158f6d37b1ed8b48fc8b5e2856064bac"
    sha256 cellar: :any,                 monterey:       "db68f8e9f523589d141b7fc0cbea8ac6b52fcf1a55a6b6761f93906f595ee339"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "08cb7da011d44055fbf57eeb6f268f5644bb78ed32c0d517437493a95b57cafe"
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
