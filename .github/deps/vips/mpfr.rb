class Mpfr < Formula
  desc "C library for multiple-precision floating-point computations"
  homepage "https://www.mpfr.org/"
  license "LGPL-3.0-or-later"

  stable do
    url "https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.0.tar.xz"
    mirror "https://ftpmirror.gnu.org/mpfr/mpfr-4.2.0.tar.xz"
    sha256 "06a378df13501248c1b2db5aa977a2c8126ae849a9d9b7be2546fb4a9c26d993"
    version "4.2.0-p7"

    # Upstream patches, list at https://www.mpfr.org/mpfr-current/#fixed
    %w[
      01 2e465c31689e780a93b24bf2959917443fb882da85b7f1ef23ae53d3de614aa4
      02 e1ef3d4dab999f4e0ad5ee046c3a2823d3a9395fb8092c3dcb85d3fe29994b52
      03 a906f9ed8e4a7230980322a0154702664164690614e5ff55ae7049c3fae55584
      04 ece14ee57596dc2e4f67d2e857c5c6b23d76b20183a50a8b6759b640df001b78
      05 c4144564097a1be89c9cc2e7ee255c9fe59eb1b94a17c9d4a08169223e705ac1
      06 70456748a8072265ba103d93ba94e9f93ae64565e6a5742194c56030086540fa
      07 472386aa5f8c51fbdf60154c19268ce2212be03e1c2f9004c1673b6c270508f6
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
    sha256 cellar: :any,                 arm64_ventura:  "63762d71ecdec7fe3f4db9beebc04e563b40b91eb9e14e07fb0f6dbcb8eb5e48"
    sha256 cellar: :any,                 arm64_monterey: "60b5b68a7aa69c508454050639fb640a3f2ce62704759f4bace7d52b7d55a3a5"
    sha256 cellar: :any,                 arm64_big_sur:  "d6f6b0e591c6091b7435e7b1f087bcef82b06971ac9a337f0b18daea131a46b0"
    sha256 cellar: :any,                 ventura:        "f37579357fad255a58c62418e5b165becf0e1ca255f65c6c79f0b058d1fb5175"
    sha256 cellar: :any,                 monterey:       "3dd0b05929aee20878832058873b16e70d385619ba9283f2884ba4bc1d9f26a9"
    sha256 cellar: :any,                 big_sur:        "dc9bc34355212367f094c766a6e9597cef12cd17df110c49b62296e2df19512f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1507a93b7779f08c5a69f2f46b99e8d2490fa599fb7fd72f64a4b9effd5505bd"
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
