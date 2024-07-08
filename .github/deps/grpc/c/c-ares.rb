class CAres < Formula
  desc "Asynchronous DNS library"
  homepage "https://c-ares.org/"
  url "https://github.com/c-ares/c-ares/releases/download/v1.32.1/c-ares-1.32.1.tar.gz"
  sha256 "63be2c4ee121faa47e9766f735b4cde750fff2c563f81c11e572d3dc6401e5e7"
  license "MIT"
  head "https://github.com/c-ares/c-ares.git", branch: "main"

  livecheck do
    url :homepage
    regex(/href=.*?c-ares[._-](\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "f1a02262be841253d3c28ec4a6e819196368634d48ebd5db335277697a0abaf6"
    sha256 cellar: :any,                 arm64_ventura:  "62d20c7afc102ea5acf87516cf2e74779f8e4a4b5f4c830cf11a1ada60e9e643"
    sha256 cellar: :any,                 arm64_monterey: "c04bf8bc8c86c95a348f1f58cb58169f01734e664b31cf7fce4d9f34f8a0101c"
    sha256 cellar: :any,                 sonoma:         "131bb254c554fb589fe2c9ac194674e6a68b37a6f978825f037acf8cde332807"
    sha256 cellar: :any,                 ventura:        "f5e91ac2001c2eea51b163734a64f894c0242d20a58b95cdc00d5d3ca4f384b3"
    sha256 cellar: :any,                 monterey:       "ae1ab2354e308a9c7c33b77cc161acc267f44bb9cfb6fbf0fa4e3884554121f9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7fddae861b1564128ded4037b8b9eadfa6bd7d87cb114ad9d27a05f7a044325b"
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
