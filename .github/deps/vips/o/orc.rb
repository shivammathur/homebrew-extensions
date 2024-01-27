class Orc < Formula
  desc "Oil Runtime Compiler (ORC)"
  homepage "https://gstreamer.freedesktop.org/projects/orc.html"
  url "https://gstreamer.freedesktop.org/src/orc/orc-0.4.36.tar.xz"
  sha256 "83b074cb67317d58bef1e8d0cc862f7ae8a77a45bbff056a1f987c6488b2f5fd"
  license all_of: ["BSD-2-Clause", "BSD-3-Clause"]

  livecheck do
    url "https://gstreamer.freedesktop.org/src/orc/"
    regex(/href=.*?orc[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "3ea4bcc14362dfa54d50dfbfee30066634b74a7aaf27b858ec4846e3a364a8cf"
    sha256 cellar: :any,                 arm64_ventura:  "a86aa01687255fb3c4916a9b98b452663e299211b563f3ee6a3c667257073d8e"
    sha256 cellar: :any,                 arm64_monterey: "cc14df97e5a61995d17a9723c64e6b43097ea2de47d8808540f760414b47e775"
    sha256 cellar: :any,                 sonoma:         "c5aca18cf2b255fcdf1c6a32f9dbe95209c8b2f7cab96a01349a7ded06ffd261"
    sha256 cellar: :any,                 ventura:        "61243ee0c7937eeed62ef0c56a0572b2f6004dcaa2814ca6ff4a3f4a9ab77608"
    sha256 cellar: :any,                 monterey:       "a9cd501cd9ff74f94f17808b0d36d6495f6000382c155336f06b05a33ab37628"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "15a48099f25204d19b405129222fd2eef25dc4868868aaa0aa079d032f968ef0"
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
