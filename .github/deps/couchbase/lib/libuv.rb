class Libuv < Formula
  desc "Multi-platform support library with a focus on asynchronous I/O"
  homepage "https://libuv.org"
  url "https://github.com/libuv/libuv/archive/refs/tags/v1.49.0.tar.gz"
  sha256 "a10656a0865e2cff7a1b523fa47d0f5a9c65be963157301f814d1cc5dbd4dc1d"
  license "MIT"
  head "https://github.com/libuv/libuv.git", branch: "v1.x"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "997f1c014b076c6744c42fcc4a351d79a32434d190d0d7678531050678eac97c"
    sha256 cellar: :any,                 arm64_sonoma:  "88e188e5184e17b56cf45a3d4680fb955eb383b735e64bbc490b5611054b221a"
    sha256 cellar: :any,                 arm64_ventura: "3407490943732986a2a6f4323414bd374a28eea26405391431561c2941b2aae3"
    sha256 cellar: :any,                 sonoma:        "de2b11ff22fb86945c0e5091c2c20b18db6c6d9a752f99878592c3afb41d01f8"
    sha256 cellar: :any,                 ventura:       "782a4a09776eac3b375636eabe37faafc63720a98950d15491f8da80d7f47351"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "82e3f0ffed17fab9aafcb2517e897a54d9dc86ed5a1a05ed7ba936c8a963fcff"
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
