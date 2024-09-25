class Harfbuzz < Formula
  desc "OpenType text shaping engine"
  homepage "https://github.com/harfbuzz/harfbuzz"
  url "https://github.com/harfbuzz/harfbuzz/archive/refs/tags/10.0.0.tar.gz"
  sha256 "b63577e1d306d787a588b22f4e656da100d60b29d4d10a2e0157b575758566e4"
  license "MIT"
  head "https://github.com/harfbuzz/harfbuzz.git", branch: "main"

  bottle do
    sha256 cellar: :any, arm64_sequoia: "2e9719b04f9784571342387fd030714292d006f340180b548db51d268f1e4b46"
    sha256 cellar: :any, arm64_sonoma:  "75a1d390f1ffeadefca6ad3c1b8f6a6bcc7090d5acf7c1bf97e2b0c71d79d7b8"
    sha256 cellar: :any, arm64_ventura: "f991b771d86c18cbb77d556570e7ba0b71b9161017be90502f82608bbd7632be"
    sha256 cellar: :any, sonoma:        "61c4136544038bf0ae82b401b0e84133e8e28839fe5f3b7d7b585ab79ae6f4cd"
    sha256 cellar: :any, ventura:       "891399517f77446d62641f338d6db4e2e75b44e32d24b3559e19be281718ddae"
    sha256               x86_64_linux:  "30f11a3352fcaef09b5ca17d4e8ec410e12190ce20231455c4b6c113074c3b4f"
  end

  depends_on "gobject-introspection" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "python@3.12" => [:build, :test]
  depends_on "pygobject3" => :test
  depends_on "cairo"
  depends_on "freetype"
  depends_on "glib"
  depends_on "graphite2"
  depends_on "icu4c"

  resource "homebrew-test-ttf" do
    url "https://github.com/harfbuzz/harfbuzz/raw/fc0daafab0336b847ac14682e581a8838f36a0bf/test/shaping/fonts/sha1sum/270b89df543a7e48e206a2d830c0e10e5265c630.ttf"
    sha256 "9535d35dab9e002963eef56757c46881f6b3d3b27db24eefcc80929781856c77"
  end

  def install
    args = %w[
      --default-library=both
      -Dcairo=enabled
      -Dcoretext=enabled
      -Dfreetype=enabled
      -Dglib=enabled
      -Dgobject=enabled
      -Dgraphite=enabled
      -Dicu=enabled
      -Dintrospection=enabled
      -Dtests=disabled
    ]

    system "meson", "setup", "build", *std_meson_args, *args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    resource("homebrew-test-ttf").stage do
      shape = pipe_output("#{bin}/hb-shape 270b89df543a7e48e206a2d830c0e10e5265c630.ttf", "സ്റ്റ്").chomp
      assert_equal "[glyph201=0+1183|U0D4D=0+0]", shape
    end
    system "python3.12", "-c", "from gi.repository import HarfBuzz"
  end
end
