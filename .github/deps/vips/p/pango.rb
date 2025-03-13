class Pango < Formula
  desc "Framework for layout and rendering of i18n text"
  homepage "https://www.gtk.org/docs/architecture/pango"
  url "https://download.gnome.org/sources/pango/1.56/pango-1.56.2.tar.xz"
  sha256 "03b7afd7ed730bef651155cbfb5320556b8ef92b0dc04abbb9784dcd4057afe7"
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
    sha256 cellar: :any, arm64_sequoia: "066a35c5a432dc0e41d9b2018ba230c1a763617457cd127facef54c03f2dfbaf"
    sha256 cellar: :any, arm64_sonoma:  "33bddc9fff28871f0875eff2e51cce86397afecf9ba21ba65b524444fa11336c"
    sha256 cellar: :any, arm64_ventura: "a0867981173b782232271e4d3ff9f34e20f00a9b52466a87f6a1546613343b59"
    sha256 cellar: :any, sonoma:        "39a78a1bb97393068d47753d7526e3256e7e1c112a170119ad7d67c77cb4a471"
    sha256 cellar: :any, ventura:       "06a195e26f4f03ca7f2cf387658dbbd3d001ae9cbf5494a369a55d8e1cabc15b"
    sha256               x86_64_linux:  "e7814fc2eedae2602bcd6482c395d801b414981c894d2fe155d61e4c97d34cb5"
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
