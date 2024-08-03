class Pinentry < Formula
  desc "Passphrase entry dialog utilizing the Assuan protocol"
  homepage "https://www.gnupg.org/related_software/pinentry/"
  url "https://www.gnupg.org/ftp/gcrypt/pinentry/pinentry-1.3.1.tar.bz2"
  mirror "https://www.mirrorservice.org/sites/ftp.gnupg.org/gcrypt/pinentry/pinentry-1.3.1.tar.bz2"
  sha256 "bc72ee27c7239007ab1896c3c2fae53b076e2c9bd2483dc2769a16902bce8c04"
  license "GPL-2.0-only"

  livecheck do
    url "https://gnupg.org/ftp/gcrypt/pinentry/"
    regex(/href=.*?pinentry[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "4a616fc6972d5fc1d62eec71faee16d51712a1c257fa7595c7cdeaeab8a35dc7"
    sha256 cellar: :any,                 arm64_ventura:  "621c724b56c3c2c3d1bda6c53a8c46323a238e3ca7d8e7403da2fa723340ee3f"
    sha256 cellar: :any,                 arm64_monterey: "41b0516e2c6ca3a409f067a5b0f1a34d64710e06fb60175e0b6e508df8c21e50"
    sha256 cellar: :any,                 sonoma:         "1538fbb8af64f8a3703d75a1d08a9e04440aa097d770d2c47b7e363e97df6aa4"
    sha256 cellar: :any,                 ventura:        "29920d31f4b229b34eaf8d4912d4ce260610212ef0f3586d8816e12bf64a067c"
    sha256 cellar: :any,                 monterey:       "c6afcdf1164022a8dafd712b729d1003d7c02aa23106fb0120862f6e6f32ebbf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6f624e07c6da1c5bca8ac869ca0012dd7aa92a98fc72a4c89b98a66063cd40b8"
  end

  depends_on "pkg-config" => :build
  depends_on "libassuan"
  depends_on "libgpg-error"

  uses_from_macos "ncurses"

  on_linux do
    depends_on "glib"
    depends_on "libsecret"
  end

  def install
    # Fix compile with newer Clang
    ENV.append_to_cflags "-Wno-implicit-function-declaration" if DevelopmentTools.clang_build_version >= 1403

    args = %w[
      --disable-silent-rules
      --disable-pinentry-fltk
      --disable-pinentry-gnome3
      --disable-pinentry-gtk2
      --disable-pinentry-qt
      --disable-pinentry-qt5
      --disable-pinentry-tqt
      --enable-pinentry-tty
    ]

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"pinentry", "--version"
    system bin/"pinentry-tty", "--version"
  end
end
