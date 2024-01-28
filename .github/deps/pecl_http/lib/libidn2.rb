class Libidn2 < Formula
  desc "International domain name library (IDNA2008, Punycode and TR46)"
  homepage "https://www.gnu.org/software/libidn/#libidn2"
  url "https://ftp.gnu.org/gnu/libidn/libidn2-2.3.5.tar.gz"
  mirror "https://ftpmirror.gnu.org/libidn/libidn2-2.3.5.tar.gz"
  mirror "http://ftp.gnu.org/gnu/libidn/libidn2-2.3.5.tar.gz"
  sha256 "0c19609b3ba7450a9c8b0536accca8d091cdd9fe6a24307af38e23b3bddec803"
  license any_of: ["GPL-2.0-or-later", "LGPL-3.0-or-later"]

  livecheck do
    url :stable
    regex(/href=.*?libidn2[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 arm64_sonoma:   "6862482aa4673a01ead7cc752289d1165c0f1592f2292a26da1571656c48c229"
    sha256 arm64_ventura:  "18ea3d276b8f225849225dc39d5bfd72e0628d2ae38ad0a7c69e225a4cf5ee07"
    sha256 arm64_monterey: "ca8cec0ba825fca688d1ed2794edb176bad67ea5509753b3d6f29dc650f019c2"
    sha256 sonoma:         "7961e97e69531215f957315f5895b756d9af0d0ab79255616fb31ce2824403f4"
    sha256 ventura:        "b6b3823f9de4b88044eae95f619dcd846888090780b0ad7d3e767efc21c107d9"
    sha256 monterey:       "fa1f5ed5ae23097e925ef722d38c12b95bcad440dd90aa2a0252b1ff07ab7a37"
    sha256 x86_64_linux:   "904b2587e5481510d7881f8c8c15df6f5988e293bfd2370ddc1ea21fc4ae7f0a"
  end

  head do
    url "https://gitlab.com/libidn/libidn2.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "gengetopt" => :build
    depends_on "gettext" => :build
    depends_on "help2man" => :build
    depends_on "libtool" => :build
    depends_on "ronn" => :build

    uses_from_macos "gperf" => :build

    on_system :linux, macos: :ventura_or_newer do
      depends_on "texinfo" => :build
    end
  end

  depends_on "pkg-config" => :build
  depends_on "libunistring"

  on_macos do
    depends_on "gettext"
  end

  def install
    args = ["--disable-silent-rules", "--with-packager=Homebrew"]
    args << "--with-libintl-prefix=#{Formula["gettext"].opt_prefix}" if OS.mac?

    system "./bootstrap", "--skip-po" if build.head?
    system "./configure", *std_configure_args, *args
    system "make", "install"
  end

  test do
    ENV.delete("LC_CTYPE")
    ENV["CHARSET"] = "UTF-8"
    output = shell_output("#{bin}/idn2 räksmörgås.se")
    assert_equal "xn--rksmrgs-5wao1o.se", output.chomp
    output = shell_output("#{bin}/idn2 blåbærgrød.no")
    assert_equal "xn--blbrgrd-fxak7p.no", output.chomp
  end
end
