class Gettext < Formula
  desc "GNU internationalization (i18n) and localization (l10n) library"
  homepage "https://www.gnu.org/software/gettext/"
  url "https://ftp.gnu.org/gnu/gettext/gettext-0.22.4.tar.gz"
  mirror "https://ftpmirror.gnu.org/gettext/gettext-0.22.4.tar.gz"
  mirror "http://ftp.gnu.org/gnu/gettext/gettext-0.22.4.tar.gz"
  sha256 "c1e0bb2a4427a9024390c662cd532d664c4b36b8ff444ed5e54b115fdb7a1aea"
  license "GPL-3.0-or-later"

  bottle do
    sha256 arm64_sonoma:   "43d00547f4a1036a642c8a41650b483f0054cd239ab4b9ca171563067c8db264"
    sha256 arm64_ventura:  "c652190aa716f3ca57678562de9cef6380d124f45a799f1f6eb1506a9b05ab1a"
    sha256 arm64_monterey: "3dd6b9cc575a927171c63822100d0597a2784258496ee134d670d946f3250a2b"
    sha256 sonoma:         "a43af8b39c3661bdc073174c6fffb49a3a1899647a541131a1cd67947807ca79"
    sha256 ventura:        "1fd9c7c6577705d3a1ce1c9064b9a853a930b63ee8984e07997758dd2c233448"
    sha256 monterey:       "f484781a99d2299b08d46c58f6c296ea9d9dd84b47ccdfbb2510b65c7344ad4a"
    sha256 x86_64_linux:   "dc631c067b99d2620dfa6994b89bd6435ab95d4f1e5f19e00eca290df8c3bc3c"
  end

  uses_from_macos "libxml2"
  uses_from_macos "ncurses"

  def install
    args = [
      "--disable-silent-rules",
      "--with-included-glib",
      "--with-included-libcroco",
      "--with-included-libunistring",
      "--with-included-libxml",
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
