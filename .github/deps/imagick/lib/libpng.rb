class Libpng < Formula
  desc "Library for manipulating PNG images"
  homepage "http://www.libpng.org/pub/png/libpng.html"
  url "https://downloads.sourceforge.net/project/libpng/libpng16/1.6.41/libpng-1.6.41.tar.xz"
  mirror "https://sourceforge.mirrorservice.org/l/li/libpng/libpng16/1.6.41/libpng-1.6.41.tar.xz"
  sha256 "d6a49a7a4abca7e44f72542030e53319c081fea508daccf4ecc7c6d9958d190f"
  license "libpng-2.0"

  livecheck do
    url :stable
    regex(%r{url=.*?/libpng[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "f64de7c3936599ea89e01644f8f1d5ff8aecc60e591aef44a929307261ea9c73"
    sha256 cellar: :any,                 arm64_ventura:  "304d3ffc7746c7194377c222ff53e97ecfb8142686d184a1609d62e8db6981e7"
    sha256 cellar: :any,                 arm64_monterey: "34e3a9aaa1b4eb6b199702642b67e2e80089d1b17c74a60be3dc91a7e17e2874"
    sha256 cellar: :any,                 sonoma:         "292b5302fdf3761e8d8a287bc47da392040991607a2cb79e31a2d46df4a2f81f"
    sha256 cellar: :any,                 ventura:        "3e9d75ad7c0995c66cde05335570cb22c88d0fe6b44c3d620edd9fcadc2a4caa"
    sha256 cellar: :any,                 monterey:       "e0940248ae42799966d164cc8f6c5706cb322fc1d3145191890010bcd5ea611d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c527128d331b52aae55334c8e570f98c7a655706e3a2d0b22831ec9ea3c2bb74"
  end

  head do
    url "https://github.com/glennrp/libpng.git", branch: "libpng16"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  uses_from_macos "zlib"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "test"
    system "make", "install"

    # Avoid rebuilds of dependants that hardcode this path.
    inreplace lib/"pkgconfig/libpng.pc", prefix, opt_prefix
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <png.h>

      int main()
      {
        png_structp png_ptr;
        png_ptr = png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
        png_destroy_write_struct(&png_ptr, (png_infopp)NULL);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lpng", "-o", "test"
    system "./test"
  end
end
