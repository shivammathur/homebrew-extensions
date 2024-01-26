class Orc < Formula
  desc "Oil Runtime Compiler (ORC)"
  homepage "https://gstreamer.freedesktop.org/projects/orc.html"
  url "https://gstreamer.freedesktop.org/src/orc/orc-0.4.35.tar.xz"
  sha256 "718cdb60db0d5f7d4fc8eb955cd0f149e0ecc78dcd5abdc6ce3be95221b793b9"
  license all_of: ["BSD-2-Clause", "BSD-3-Clause"]

  livecheck do
    url "https://gstreamer.freedesktop.org/src/orc/"
    regex(/href=.*?orc[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "e252ffe2ce9238b8c94890a3459d4810c5010e5089a34264bc50081b6b1e5a94"
    sha256 cellar: :any,                 arm64_ventura:  "f6fc9f9074e398c5ede6469a5b8e5e47ef81e728eafa0c3fd972a2929dd39d42"
    sha256 cellar: :any,                 arm64_monterey: "57f142c116f34eed3a931eeb17ff86ddb307ed776bb9a1a09a6d6a74ea81b41d"
    sha256 cellar: :any,                 sonoma:         "451234e0bfea08784a51498e1b4a78a359e461734df9269de97602ac6b7af6f1"
    sha256 cellar: :any,                 ventura:        "b195aa5761b87264f240643a76620a1e4aac0f4e5addeca95716af34d0499de0"
    sha256 cellar: :any,                 monterey:       "07dc21aafa724e91323e9d5898bdf7685e9e72b5211502882f152748181b62c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "19e3078669581e456fb6ded5666f058c6951f19129d22e88cb092448721c7058"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build

  def install
    system "meson", "setup", "build", "-Dgtk_doc=disabled", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/orcc --version 2>&1")

    (testpath/"test.c").write <<~EOS
      #include <orc/orc.h>

      int main(int argc, char *argv[]) {
        if (orc_version_string() == NULL) {
          return 1;
        }
        return 0;
      }
    EOS

    system ENV.cc, "test.c", "-I#{include}/orc-0.4", "-L#{lib}", "-lorc-0.4", "-o", "test"
    system "./test"
  end
end
