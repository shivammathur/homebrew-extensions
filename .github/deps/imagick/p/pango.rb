class Pango < Formula
  desc "Framework for layout and rendering of i18n text"
  homepage "https://www.gtk.org/docs/architecture/pango"
  url "https://download.gnome.org/sources/pango/1.55/pango-1.55.5.tar.xz"
  sha256 "e396126ea08203cbd8ef12638e6222e2e1fd8aa9cac6743072fedc5f2d820dd8"
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
    sha256 cellar: :any, arm64_sequoia: "da6add992b77c7bce5fa61a07c88a21ae199e031a92f2986d0a9e1e35734c6e2"
    sha256 cellar: :any, arm64_sonoma:  "d9300868a6a5ca623ee953735cb5de817d74faa2d595f85d7ed91096e6cc6672"
    sha256 cellar: :any, arm64_ventura: "fe27bd895abe0a5bcc0509e2c186bd30db1648467200a76652976f4ecc55119b"
    sha256 cellar: :any, sonoma:        "6239e9516758133f782474743e63429aef6a3de0a0838a89219374486d4be984"
    sha256 cellar: :any, ventura:       "80ded1b0803373c0dbe98ff80f5817ca0ab467d1b902b0647d99d27875ffb5d5"
    sha256               x86_64_linux:  "f45a26a017af5b2ee18f9aac8993935d12e8f43df1597da1a87caf625f2f7d34"
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
