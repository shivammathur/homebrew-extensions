class Gettext < Formula
  desc "GNU internationalization (i18n) and localization (l10n) library"
  homepage "https://www.gnu.org/software/gettext/"
  url "https://ftp.gnu.org/gnu/gettext/gettext-0.23.tar.gz"
  mirror "https://ftpmirror.gnu.org/gettext/gettext-0.23.tar.gz"
  mirror "http://ftp.gnu.org/gnu/gettext/gettext-0.23.tar.gz"
  sha256 "945dd7002a02dd7108ad0510602e13416b41d327898cf8522201bc6af10907a6"
  license "GPL-3.0-or-later"

  bottle do
    sha256 arm64_sequoia: "920c38bf7e32b5e72c9863f35332d47e8b3b972256a5c2b49ca454beeadd2984"
    sha256 arm64_sonoma:  "2041dafd8f25affab963100bd7735c493abc0efef0ca141a9239ac6fc60e5a19"
    sha256 arm64_ventura: "dbdefb1ee1b6de90e4cca9d5a370239d19e9f1cbb9f07892dd046de134d3cebc"
    sha256 sonoma:        "c93fc77db63462932e615d295ef455f3dab6d4c0ec0f20db130082998ee6ac57"
    sha256 ventura:       "4a9d298346e29db0230996416a154e54fdc8056fdb268ef7493576d82aadb9e2"
    sha256 x86_64_linux:  "17a3a3358d80af17a45be7d2b71b4d1961bd1b044cf83e3d0457c3a54a6ce85f"
  end

  depends_on "libunistring"

  uses_from_macos "libxml2"
  uses_from_macos "ncurses"

  on_linux do
    depends_on "acl"
  end

  def install
    # macOS iconv implementation is slightly broken since Sonoma.
    # This is also why we skip `make check`.
    # upstream bug report, https://savannah.gnu.org/bugs/index.php?66541
    ENV["am_cv_func_iconv_works"] = "yes" if OS.mac? && MacOS.version == :sequoia

    args = [
      "--with-libunistring-prefix=#{Formula["libunistring"].opt_prefix}",
      "--disable-silent-rules",
      "--with-included-glib",
      "--with-included-libcroco",
      "--with-emacs",
      "--with-lispdir=#{elisp}",
      "--disable-java",
      "--disable-csharp",
      # Don't use VCS systems to create these archives
      "--without-git",
      "--without-cvs",
      "--without-xz",
    ]
    args << if OS.mac?
      # Ship libintl.h. Disabled on linux as libintl.h is provided by glibc
      # https://gcc-help.gcc.gnu.narkive.com/CYebbZqg/cc1-undefined-reference-to-libintl-textdomain
      # There should never be a need to install gettext's libintl.h on
      # GNU/Linux systems using glibc. If you have it installed you've borked
      # your system somehow.
      "--with-included-gettext"
    else
      "--with-libxml2-prefix=#{Formula["libxml2"].opt_prefix}"
    end

    system "./configure", *std_configure_args, *args
    system "make"
    ENV.deparallelize # install doesn't support multiple make jobs
    system "make", "install"
  end

  test do
    system bin/"gettext", "test"
  end
end
