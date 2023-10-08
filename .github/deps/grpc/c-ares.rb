class CAres < Formula
  desc "Asynchronous DNS library"
  homepage "https://c-ares.org/"
  url "https://c-ares.org/download/c-ares-1.20.0.tar.gz"
  mirror "https://github.com/c-ares/c-ares/releases/download/cares-1_17_2/c-ares-1.20.0.tar.gz"
  mirror "http://fresh-center.net/linux/misc/dns/c-ares-1.20.0.tar.gz"
  mirror "http://fresh-center.net/linux/misc/dns/legacy/c-ares-1.20.0.tar.gz"
  sha256 "cde8433e9bf6c6a0d9e7e69947745ee649256d76009d6c23b9555f84c5c13988"
  license "MIT"
  head "https://github.com/c-ares/c-ares.git", branch: "main"

  livecheck do
    url :homepage
    regex(/href=.*?c-ares[._-](\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "8db865fe42a6bc380bf09a53dc13f038ca335d0ef4add06c8c6e723df2b1d922"
    sha256 cellar: :any,                 arm64_ventura:  "9c0c6e486400209df354cd828b5f2b19ca17e2e7a60bd42ff20eea633b313d70"
    sha256 cellar: :any,                 arm64_monterey: "c244529d6f9f67c1cfe3d95e0eb8bd5d7f1a9ee8d7fb5ff2e3248a125436bf73"
    sha256 cellar: :any,                 sonoma:         "975494e231e47510129093f4db724b46260c7796a3de454a86a3563767711e29"
    sha256 cellar: :any,                 ventura:        "3707fcbe9a18c34d9dc80da6d2fee7f280acc56faa406191d798f53ecde3f775"
    sha256 cellar: :any,                 monterey:       "15465c1cec8ba85a6682c11317a779ff402f09ead3d2ce2064261debfc3f3199"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d8bdaaaf273b5398a1ab62913914ad445f7ed1fad3a99af5f25c4c9e2d6916a6"
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
