class CAres < Formula
  desc "Asynchronous DNS library"
  homepage "https://c-ares.org/"
  url "https://c-ares.org/download/c-ares-1.25.0.tar.gz"
  mirror "https://github.com/c-ares/c-ares/releases/download/cares-1_17_2/c-ares-1.25.0.tar.gz"
  mirror "http://fresh-center.net/linux/misc/dns/c-ares-1.25.0.tar.gz"
  mirror "http://fresh-center.net/linux/misc/dns/legacy/c-ares-1.25.0.tar.gz"
  sha256 "71832b93a48f5ff579c505f4869120c14e57b783275367207f1a98314aa724e5"
  license "MIT"
  head "https://github.com/c-ares/c-ares.git", branch: "main"

  livecheck do
    url :homepage
    regex(/href=.*?c-ares[._-](\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "00d1179348a7c14de25620f6924596b899228b731118e0f92d67168e9b952da9"
    sha256 cellar: :any,                 arm64_ventura:  "ba6e16a0812afeca95ba221a818c9efb6d351d68ad4a496f635bd86c18d382be"
    sha256 cellar: :any,                 arm64_monterey: "21f896efe780b1f125efe7e3ec7d803769f90a4a46f3134e6fece5b6d61aa925"
    sha256 cellar: :any,                 sonoma:         "2efe54dd3c27cd85912dfb3cc6ee38c3ede65755202c7032f2b8e44ca892a0c4"
    sha256 cellar: :any,                 ventura:        "e22273631fdd0c8dd691f27330355d33114fc9eee3540cda598a8d634038fac5"
    sha256 cellar: :any,                 monterey:       "ea4d893ff207286407cba6dbc66ff725d1023c163d5027fbc66f1032926db6ef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bd6ccfca8c33c073f80e63ab3896d53274a677fa865e9dd5048297cf061a2997"
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
