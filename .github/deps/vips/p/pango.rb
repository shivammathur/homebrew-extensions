class Pango < Formula
  desc "Framework for layout and rendering of i18n text"
  homepage "https://www.gtk.org/docs/architecture/pango"
  url "https://download.gnome.org/sources/pango/1.56/pango-1.56.0.tar.xz"
  sha256 "1fb98b338ee6f7cf8ef96153b7d242f4568fe60f9b7434524eca630a57bd538b"
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
    sha256 cellar: :any, arm64_sequoia: "e2ef4cb8cf3873c305583007042b28c671f4304a98b61393d55d648c0adeeb99"
    sha256 cellar: :any, arm64_sonoma:  "d8b10b2f3a325e83d3708521b22036df61443b4893769e0746df8c0c494df346"
    sha256 cellar: :any, arm64_ventura: "7af3642f5c4fa54379458abb5886fffe2b8fd9317cf79f2dd7642b37effbe7b0"
    sha256 cellar: :any, sonoma:        "9bbbc81df1caaa6542d0f44a0589246a1bc63f76e7931fd0dbfc590282e1e6eb"
    sha256 cellar: :any, ventura:       "8af53c650b5a85678b094257eeb34a12c8a361784d9c733bfe943721aff7b79b"
    sha256               x86_64_linux:  "527535d140cb4aea12448046f8024e7cf185ecac583c6e4127fa987a5a32a8fa"
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
