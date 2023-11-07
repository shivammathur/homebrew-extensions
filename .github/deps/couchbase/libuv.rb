class Libuv < Formula
  desc "Multi-platform support library with a focus on asynchronous I/O"
  homepage "https://libuv.org"
  url "https://github.com/libuv/libuv/archive/refs/tags/v1.47.0.tar.gz"
  sha256 "d50af7e6d72526db137e66fad812421c8a1cae09d146b0ec2bb9a22c5f23ba93"
  license "MIT"
  head "https://github.com/libuv/libuv.git", branch: "v1.x"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "8ec04556c7b8b6a8a08c0ede32afa92d69d23b3d8e238eccf524a12e72532ce6"
    sha256 cellar: :any,                 arm64_ventura:  "05e8c9cdb92b838680bd8e1525bdcf04b60e1829508cd185f11bc84d2389e188"
    sha256 cellar: :any,                 arm64_monterey: "b554d60cbe799f23f6b41c0080a93dabb931b76c01cff79ace7cb921755e526e"
    sha256 cellar: :any,                 sonoma:         "30fc2f83208f6eff71dafa647e384a8cd29b0c29f4f51fc109d9c18374eed74d"
    sha256 cellar: :any,                 ventura:        "d512e90e778bff53c92cb261dfc0d02f535405f63d784743a67776771b4f2356"
    sha256 cellar: :any,                 monterey:       "634c0c3d595607136e77b16ac49181879511fbfb922af65bf43e8a236f49b587"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "593f317a0edb0b7ea18f1fd4f25d9f8a374e596ffe28a375cdbd43a2e5e7c9b7"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "sphinx-doc" => :build

  def install
    # This isn't yet handled by the make install process sadly.
    cd "docs" do
      system "make", "man"
      man1.install "build/man/libuv.1"
    end

    system "./autogen.sh"
    system "./configure", *std_configure_args,
                          "--disable-silent-rules"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <uv.h>
      #include <stdlib.h>

      int main()
      {
        uv_loop_t* loop = malloc(sizeof *loop);
        uv_loop_init(loop);
        uv_loop_close(loop);
        free(loop);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-luv", "-o", "test"
    system "./test"
  end
end
