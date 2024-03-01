class Openjpeg < Formula
  desc "Library for JPEG-2000 image manipulation"
  homepage "https://www.openjpeg.org/"
  url "https://github.com/uclouvain/openjpeg/archive/refs/tags/v2.5.1.tar.gz"
  sha256 "c0b92dadd65e33b1cf94f39dd9157d5469846744c2e0afb8ca10961f51f61da6"
  license "BSD-2-Clause"
  head "https://github.com/uclouvain/openjpeg.git", branch: "master"

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "3e5e234a15bfb9327665c345bde4663b4883ebc14f2362bbbcb29941366d1f1b"
    sha256 cellar: :any,                 arm64_ventura:  "c986d4c75923d4978323504ebd9b8bac32c3a87cc68bbe82044d927c9bdd6626"
    sha256 cellar: :any,                 arm64_monterey: "13cb2341f7d6b057e708c30194e6e0140b17da7cc66b5c122bc8489b1ee7b39c"
    sha256 cellar: :any,                 sonoma:         "ce3fa393dbd776295c254e4ec575b138d975d68976080f543b31caee9f9bbda3"
    sha256 cellar: :any,                 ventura:        "268c6bc9cf31bd4545be45f71326159536f54d00d7204a002b9a053ebeaacf2f"
    sha256 cellar: :any,                 monterey:       "f63cc5ed1b043efdec0e5ef1a652b8be4859b568f2303e03cc6c312afee01b99"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "43773d25db13d3a65292053864e485be8812de07086391cdbf5d5de0f001681b"
  end

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "little-cms2"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args,
                    "-DCMAKE_INSTALL_RPATH=#{rpath}",
                    "-DBUILD_DOC=ON"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <openjpeg.h>

      int main () {
        opj_image_cmptparm_t cmptparm;
        const OPJ_COLOR_SPACE color_space = OPJ_CLRSPC_GRAY;

        opj_image_t *image;
        image = opj_image_create(1, &cmptparm, color_space);

        opj_image_destroy(image);
        return 0;
      }
    EOS
    system ENV.cc, "-I#{include.children.first}",
           testpath/"test.c", "-L#{lib}", "-lopenjp2", "-o", "test"
    system "./test"
  end
end
