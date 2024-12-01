class Pango < Formula
  desc "Framework for layout and rendering of i18n text"
  homepage "https://www.gtk.org/docs/architecture/pango"
  url "https://download.gnome.org/sources/pango/1.55/pango-1.55.0.tar.xz"
  sha256 "a2c17a8dc459a7267b8b167bb149d23ff473b6ff9d5972bee047807ee2220ccf"
  license "LGPL-2.0-or-later"
  head "https://gitlab.gnome.org/GNOME/pango.git", branch: "main"

  # Pango doesn't follow GNOME's "even-numbered minor is stable" version
  # scheme but they do appear to use 90+ minor/patch versions, which may
  # indicate unstable versions (e.g., 1.90, etc.).
  livecheck do
    url "https://download.gnome.org/sources/pango/cache.json"
    regex(/pango[._-]v?(\d+(?:(?!\.9\d)\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_sequoia: "621f7759d9ae4092f2a1eeb0b887c3fd93753b8e661a50a606a98cfe12ba40f1"
    sha256 cellar: :any, arm64_sonoma:  "31a03cab8418be5d5b291a1ca186ea16b1ec03efd5e27284ea23dd3315dc694c"
    sha256 cellar: :any, arm64_ventura: "1ddab03ec0add7d99db535ddde262f80f865920285fced352b3fca2080b6db31"
    sha256 cellar: :any, sonoma:        "97783cf87a684b663e64aef0cdfe6282ae7c3e1b48880382faf64ef8d0a2ce97"
    sha256 cellar: :any, ventura:       "8fc0cd4faed022d79952801e0f5a490df5b9a9cded45089758b38632fd101b33"
    sha256               x86_64_linux:  "26a54b4015acaba17cf191a1a7c9047d49231b8ae638d86330528da6416b4e6d"
  end

  depends_on "gobject-introspection" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => [:build, :test]
  depends_on "cairo"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "fribidi"
  depends_on "glib"
  depends_on "harfbuzz"

  def install
    args = %w[
      -Ddefault_library=both
      -Dintrospection=enabled
      -Dfontconfig=enabled
      -Dcairo=enabled
      -Dfreetype=enabled
    ]

    system "meson", "setup", "build", *args, *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    system bin/"pango-view", "--version"
    (testpath/"test.c").write <<~C
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
    C

    flags = shell_output("pkgconf --cflags --libs pangocairo").chomp.split
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"
  end
end
