class Mpfr < Formula
  desc "C library for multiple-precision floating-point computations"
  homepage "https://www.mpfr.org/"
  license "LGPL-3.0-or-later"

  stable do
    url "https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.0.tar.xz"
    mirror "https://ftpmirror.gnu.org/mpfr/mpfr-4.2.0.tar.xz"
    sha256 "06a378df13501248c1b2db5aa977a2c8126ae849a9d9b7be2546fb4a9c26d993"
    version "4.2.0-p4"

    # Upstream patches, list at https://www.mpfr.org/mpfr-current/#fixed
    %w[
      01 2e465c31689e780a93b24bf2959917443fb882da85b7f1ef23ae53d3de614aa4
      02 e1ef3d4dab999f4e0ad5ee046c3a2823d3a9395fb8092c3dcb85d3fe29994b52
      03 a906f9ed8e4a7230980322a0154702664164690614e5ff55ae7049c3fae55584
      04 ece14ee57596dc2e4f67d2e857c5c6b23d76b20183a50a8b6759b640df001b78
    ].each_slice(2) do |p, checksum|
      patch do
        url "https://www.mpfr.org/mpfr-4.2.0/patch#{p}"
        sha256 checksum
      end
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
    sha256 cellar: :any,                 arm64_ventura:  "29059373c34b281cd132fa85156d0204c13234784db2bdffe38ec3e811b7d1f5"
    sha256 cellar: :any,                 arm64_monterey: "e0b7ed2e2193713888f9383dd30bece8b4f70c7a2d51b107043bf5bbe9375c7d"
    sha256 cellar: :any,                 arm64_big_sur:  "dd46ecce5cd9ac6cca15c1d3323ba093e09a883c6f5b57fb2a3c7936ab9c4f11"
    sha256 cellar: :any,                 ventura:        "5f63edde1beb887614e0458ed1f04f75096d01260801da3462a045a8d7948e81"
    sha256 cellar: :any,                 monterey:       "a0d6a033e9b54135c1d0605c9ddbe1618e15c676e1d7a16b95f52fca16c64de4"
    sha256 cellar: :any,                 big_sur:        "9fc6770d6fc85ee19f4d81a9cf90009c3804b079ab74af2fa58c2097113c3675"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e606ea839f1440962abb109764179e3f56e5de538214878ed5d23fd1cc9d04a1"
  end

  head do
    url "https://gitlab.inria.fr/mpfr/mpfr.git", branch: "master"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "gmp"

  def install
    system "./autogen.sh" if build.head?

    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}",
                          "--disable-silent-rules"
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
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
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-L#{Formula["gmp"].opt_lib}",
                   "-lgmp", "-lmpfr", "-o", "test"
    system "./test"
  end
end
