class Mpfr < Formula
  desc "C library for multiple-precision floating-point computations"
  homepage "https://www.mpfr.org/"
  url "https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.1.tar.xz"
  mirror "https://ftpmirror.gnu.org/mpfr/mpfr-4.2.1.tar.xz"
  version "4.2.1-p1"
  sha256 "277807353a6726978996945af13e52829e3abd7a9a5b7fb2793894e18f1fcbb2"
  license "LGPL-3.0-or-later"
  head "https://gitlab.inria.fr/mpfr/mpfr.git", branch: "master"

  # Upstream patches, list at https://www.mpfr.org/mpfr-current/#fixed
  %w[
    01 3ec29a67cfa75c35e90d32cafa552956018c79526b4aa412f3beff21dacfb41e
  ].each_slice(2) do |p, checksum|
    patch do
      url "https://www.mpfr.org/mpfr-4.2.1/patch#{p}"
      sha256 checksum
    end
  end

  livecheck do
    url "https://www.mpfr.org/mpfr-current/"
    regex(/href=.*?mpfr[._-]v?(\d+(?:\.\d+)+)\.t/i)
    strategy :page_match do |page, regex|
      version = page.scan(regex).map { |match| Version.new(match[0]) }.max&.to_s
      next if version.blank?

      patch = page.scan(%r{href=["']?/?patch(\d+)["' >]}i)
                  .map { |match| Version.new(match[0]) }
                  .max
                  &.to_s
      next version if patch.blank?

      "#{version}-p#{patch.to_i}"
    end
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "7681c552a36cdb76ae27a85890c7d0c53839de1d258cb338a0140af8dec3e6ec"
    sha256 cellar: :any,                 arm64_sonoma:  "9caf9ecffc77d2b880604b5f17daabe425503d7a3049ec07328bb27365d99806"
    sha256 cellar: :any,                 arm64_ventura: "afe9df468349ca8f54931e4522f9dc6b61bac40a75625d94f3019cafe1e5ee39"
    sha256 cellar: :any,                 sonoma:        "a6e9493b190dbd51bded0cacdc8acad0ad660ef5d7bbc531f956ae2b6dc91695"
    sha256 cellar: :any,                 ventura:       "e5c4c1b9aa9e6a295d492b234ea89fd650eb3e61ad1fea8c9ba83013324539c9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ad9e72febad8f534c2222d3a11b54caefbcb5607960e4cf8ced0edf3a8afb18c"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "gmp"

  on_system :linux, macos: :ventura_or_newer do
    depends_on "texinfo" => :build
  end

  def install
    system "./autogen.sh" if build.head?

    odie "check if autoreconf line can be removed" if version > "4.2.1-p1"
    # regenerate since the files were generated using automake 1.17
    system "autoreconf", "--force", "--install", "--verbose"

    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <mpfr.h>
      #include <math.h>
      #include <stdlib.h>
      #include <string.h>

      int main() {
        mpfr_t x, y;
        mpfr_inits2 (256, x, y, NULL);
        mpfr_set_ui (x, 2, MPFR_RNDN);
        mpfr_rootn_ui (y, x, 2, MPFR_RNDN);
        mpfr_pow_si (x, y, 4, MPFR_RNDN);
        mpfr_add_si (y, x, -4, MPFR_RNDN);
        mpfr_abs (y, y, MPFR_RNDN);
        if (fabs(mpfr_get_d (y, MPFR_RNDN)) > 1.e-30) abort();
        if (strcmp("#{version}", mpfr_get_version())) abort();
        return 0;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-L#{Formula["gmp"].opt_lib}",
                   "-lgmp", "-lmpfr", "-o", "test"
    system "./test"
  end
end
