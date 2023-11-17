class Libksba < Formula
  desc "X.509 and CMS library"
  homepage "https://www.gnupg.org/related_software/libksba/"
  url "https://gnupg.org/ftp/gcrypt/libksba/libksba-1.6.5.tar.bz2"
  sha256 "a564628c574c99287998753f98d750babd91a4e9db451f46ad140466ef2a6d16"
  license any_of: ["LGPL-3.0-or-later", "GPL-2.0-or-later"]

  livecheck do
    url "https://gnupg.org/ftp/gcrypt/libksba/"
    regex(/href=.*?libksba[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "93312a56b490f76c4b604c33e632b422265c34147f1f9ad55067b3ef7fd0d099"
    sha256 cellar: :any,                 arm64_ventura:  "81f002affe891ceaaa0242e5e7199b5e8367eb07fe722025193daa32f3946553"
    sha256 cellar: :any,                 arm64_monterey: "9ab2c0432db8783f4d9ffd3f53ecfefb1a7684ef832d2e821b2109aec061d19b"
    sha256 cellar: :any,                 sonoma:         "db3d3ccc012b420632652c7215040cae34d40d5a26ebcd0dbe5dc17a37c0891e"
    sha256 cellar: :any,                 ventura:        "93433a6a85878e91204e7d3af6af33fb4228e0531aba5eac09d03e82625c8361"
    sha256 cellar: :any,                 monterey:       "a8155dd662463493099fff85ce9b5b5808bd64256ccdaa05fc7eee38f4a2da3e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "78933dcda1ee84b6366f13bb712298ad2453080ab1ad26d3ac008fa39f3dcc36"
  end

  depends_on "libgpg-error"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "check"
    system "make", "install"

    # avoid triggering mandatory rebuilds of software that hard-codes this path
    inreplace [bin/"ksba-config", lib/"pkgconfig/ksba.pc"], prefix, opt_prefix
  end

  test do
    (testpath/"ksba-test.c").write <<~C
      #include "ksba.h"
      #include <stdio.h>
      int main() {
        printf("%s", ksba_check_version(NULL));
        return 0;
      }
    C

    ENV.append_to_cflags shell_output("#{bin}/ksba-config --cflags").strip
    ENV.append "LDLIBS", shell_output("#{bin}/ksba-config --libs").strip

    system "make", "ksba-test"
    assert_equal version.to_s, shell_output("./ksba-test")
  end
end
