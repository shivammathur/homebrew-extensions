class Pango < Formula
  desc "Framework for layout and rendering of i18n text"
  homepage "https://pango.gnome.org"
  url "https://download.gnome.org/sources/pango/1.50/pango-1.50.13.tar.xz"
  sha256 "5cdcf6d761d26a3eb9412b6cb069b32bd1d9b07abf116321167d94c2189299fd"
  license "LGPL-2.0-or-later"
  head "https://gitlab.gnome.org/GNOME/pango.git", branch: "main"

  bottle do
    sha256 cellar: :any, arm64_ventura:  "ccf88ba6903f9448a6cee13a2d8359f145a4e48d9551bcfb8191202291bc580b"
    sha256 cellar: :any, arm64_monterey: "afde6bb8f8f4d98558ce3f4c5706bc44028505bd4e7fdc06a00aee4071562b90"
    sha256 cellar: :any, arm64_big_sur:  "188af7379c592561e39c971e8852d188527b739885453ab2215275727eb0ed3e"
    sha256 cellar: :any, ventura:        "b6772bf91ed9df79dc5ff5c6d4275421cd82661453b9727100b0554077db4329"
    sha256 cellar: :any, monterey:       "9ec7a34fe2e7015941507123e0c7aef8c068fc9404b0c8f3bc657f3b33ea44ba"
    sha256 cellar: :any, big_sur:        "d697dc340dd22305569a975190443f237ce38c2ef122aa2fcdf40daafe19cf19"
    sha256               x86_64_linux:   "25a3e82adf2c8cddabf50d9dcb12c8c4a05232600477ac77c60c86f83f62d95b"
  end

  depends_on "gobject-introspection" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "cairo"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "fribidi"
  depends_on "glib"
  depends_on "harfbuzz"

  def install
    system "meson", *std_meson_args, "build",
                    "-Ddefault_library=both",
                    "-Dintrospection=enabled",
                    "-Dfontconfig=enabled",
                    "-Dcairo=enabled",
                    "-Dfreetype=enabled"
    system "meson", "compile", "-C", "build", "-v"
    system "meson", "install", "-C", "build"
  end

  test do
    system bin/"pango-view", "--version"
    (testpath/"test.c").write <<~EOS
      #include <pango/pangocairo.h>

      int main(int argc, char *argv[]) {
        PangoFontMap *fontmap;
        int n_families;
        PangoFontFamily **families;
        fontmap = pango_cairo_font_map_get_default();
        pango_font_map_list_families (fontmap, &families, &n_families);
        g_free(families);
        return 0;
      }
    EOS
    cairo = Formula["cairo"]
    fontconfig = Formula["fontconfig"]
    freetype = Formula["freetype"]
    gettext = Formula["gettext"]
    glib = Formula["glib"]
    harfbuzz = Formula["harfbuzz"]
    libpng = Formula["libpng"]
    pixman = Formula["pixman"]
    flags = %W[
      -I#{cairo.opt_include}/cairo
      -I#{fontconfig.opt_include}
      -I#{freetype.opt_include}/freetype2
      -I#{gettext.opt_include}
      -I#{glib.opt_include}/glib-2.0
      -I#{glib.opt_lib}/glib-2.0/include
      -I#{harfbuzz.opt_include}/harfbuzz
      -I#{include}/pango-1.0
      -I#{libpng.opt_include}/libpng16
      -I#{pixman.opt_include}/pixman-1
      -D_REENTRANT
      -L#{cairo.opt_lib}
      -L#{gettext.opt_lib}
      -L#{glib.opt_lib}
      -L#{lib}
      -lcairo
      -lglib-2.0
      -lgobject-2.0
      -lpango-1.0
      -lpangocairo-1.0
    ]
    flags << "-lintl" if OS.mac?
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"
  end
end
