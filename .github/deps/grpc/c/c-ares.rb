class CAres < Formula
  desc "Asynchronous DNS library"
  homepage "https://c-ares.org/"
  url "https://c-ares.org/download/c-ares-1.22.1.tar.gz"
  mirror "https://github.com/c-ares/c-ares/releases/download/cares-1_17_2/c-ares-1.22.1.tar.gz"
  mirror "http://fresh-center.net/linux/misc/dns/c-ares-1.22.1.tar.gz"
  mirror "http://fresh-center.net/linux/misc/dns/legacy/c-ares-1.22.1.tar.gz"
  sha256 "f67c180deb799c670d9dda995a18ce06f6c7320b6c6363ff8fa85b77d0da9db8"
  license "MIT"
  head "https://github.com/c-ares/c-ares.git", branch: "main"

  livecheck do
    url :homepage
    regex(/href=.*?c-ares[._-](\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "522b830ce4f2f855a62b8d108c799e1bcc22ccd7881ef993d8d1ce6d8642b2eb"
    sha256 cellar: :any,                 arm64_ventura:  "aa98678b007ca977cc86ac4ea06e540fe394076bdc43ed74ffbc2ac6b7831837"
    sha256 cellar: :any,                 arm64_monterey: "958550e764728c7abc625a5eca44227f1ec4dbd964396d7617915108faa46752"
    sha256 cellar: :any,                 sonoma:         "c84379accf9eddb2e4ee362b2657d7799f157c43b7ee91dba2f8d84be383b7d4"
    sha256 cellar: :any,                 ventura:        "fd984fae219405d6cb56ae86c93f09d16afc6499eec952378f7d5d79f2a555ae"
    sha256 cellar: :any,                 monterey:       "245fda65de52dff4d56b8d876fc2e63de23196ac7364b67988657fb5b6a81af7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7c2434846f93f509154919cb3a53d45db412861388936a6785b8d24ca89b071b"
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
