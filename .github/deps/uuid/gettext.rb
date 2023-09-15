class Gettext < Formula
  desc "GNU internationalization (i18n) and localization (l10n) library"
  homepage "https://www.gnu.org/software/gettext/"
  url "https://ftp.gnu.org/gnu/gettext/gettext-0.21.1.tar.gz"
  mirror "https://ftpmirror.gnu.org/gettext/gettext-0.21.1.tar.gz"
  mirror "http://ftp.gnu.org/gnu/gettext/gettext-0.21.1.tar.gz"
  sha256 "e8c3650e1d8cee875c4f355642382c1df83058bd5a11ee8555c0cf276d646d45"
  license "GPL-3.0-or-later"

  bottle do
    sha256 arm64_sonoma:   "f26633ef6addce56c288a62b844ac3fb629aaa90ae936dd4130500003d0fa6af"
    sha256 arm64_ventura:  "28c5b06e66800aa2d460336d001379e35e664310d12638de35a1b0f2b9a44913"
    sha256 arm64_monterey: "356b52e24b883af3ef092d13b6727b76e0137154c2c9eb42fe7c272bb7d3edec"
    sha256 arm64_big_sur:  "90da957f7b8ad3d47fff7045a684060168e0433631921463fbbff09b5dc4b772"
    sha256 sonoma:         "c387ad29be189757420e9e774d7697f705f0b44c80c63cb43cef4ce67b1caa8a"
    sha256 ventura:        "fd7e48065cf73e37dfdf4c5cb789a14b93cf58ac06060814a60c94b87d8f26e6"
    sha256 monterey:       "9318777367eae475e9ea226d2bcbd19ef8281d1dd2af3a92c20c00246677145b"
    sha256 big_sur:        "95086fa8b1b6a913ca7ef3a7c7c49e147823c26ba239003f9140cfe1252587ba"
    sha256 catalina:       "aba2b94f406a9d8784bb08f9763440297c645a7ea99f4c4dbfeccb325053322a"
    sha256 x86_64_linux:   "991579fa170ca491fd6332844b570095978961a9764e57f00180002d471cf3b8"
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

    # Sonoma iconv() has a regression w.r.t. transliteration, which happens to
    # break gettext's configure check. Force it.
    # Reported to Apple as FB13163914
    args << "am_cv_func_iconv_works=y" if OS.mac? && MacOS.version == :sonoma

    system "./configure", *std_configure_args, *args
    system "make"
    ENV.deparallelize # install doesn't support multiple make jobs
    system "make", "install"
  end

  test do
    system bin/"gettext", "test"
  end
end
