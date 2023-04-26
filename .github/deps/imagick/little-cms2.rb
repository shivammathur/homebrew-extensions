class LittleCms2 < Formula
  desc "Color management engine supporting ICC profiles"
  homepage "https://www.littlecms.com/"
  # Ensure release is announced at https://www.littlecms.com/categories/releases/
  # (or https://www.littlecms.com/blog/)
  url "https://downloads.sourceforge.net/project/lcms/lcms/2.14/lcms2-2.14.tar.gz"
  sha256 "28474ea6f6591c4d4cee972123587001a4e6e353412a41b3e9e82219818d5740"
  license "MIT"
  revision 1
  version_scheme 1

  # The Little CMS website has been redesigned and there's no longer a
  # "Download" page we can check for releases. As of writing this, checking the
  # "Releases" blog posts seems to be our best option and we just have to hope
  # that the post URLs, headings, etc. maintain a consistent format.
  livecheck do
    url "https://www.littlecms.com/categories/releases/"
    regex(/Little\s*CMS\s+v?(\d+(?:\.\d+)+)\s+released/im)
  end

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "6ed3ea3deebe26c480a8645f2c38fbc0f9f1a4fd47de411931eab04c950ac450"
    sha256 cellar: :any,                 arm64_monterey: "3c4cc7b5b25f90f9f35f24440f6ba65dc2eca4efc1e556dc6333b20b26baf74f"
    sha256 cellar: :any,                 arm64_big_sur:  "fa940e0ad62a9e01c72843bad7190873e7b6eb0415689b0cdf5c440c07ea77d4"
    sha256 cellar: :any,                 ventura:        "bd740aa54f78a727dbc760b83f43238a5b177d05254885859398f31023a23cba"
    sha256 cellar: :any,                 monterey:       "668a20c35919f9fc1837ecbae0f14213ed57de96a2659e2fe0b3c3199d0a7aa8"
    sha256 cellar: :any,                 big_sur:        "d28397d577f74221703190c242ee5811c2af0275c82bf5c31682766bd7ee12f1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4ab9a233cfa9e76f303dde3cf787b6d1f9c1b53bd85262088ea2012c18bbb8ce"
  end

  depends_on "jpeg-turbo"
  depends_on "libtiff"

  def install
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    system "#{bin}/jpgicc", test_fixtures("test.jpg"), "out.jpg"
    assert_predicate testpath/"out.jpg", :exist?
  end
end
