class Harfbuzz < Formula
  desc "OpenType text shaping engine"
  homepage "https://github.com/harfbuzz/harfbuzz"
  url "https://github.com/harfbuzz/harfbuzz/archive/refs/tags/10.0.1.tar.gz"
  sha256 "e7358ea86fe10fb9261931af6f010d4358dac64f7074420ca9bc94aae2bdd542"
  license "MIT"
  head "https://github.com/harfbuzz/harfbuzz.git", branch: "main"

  bottle do
    sha256 cellar: :any, arm64_sequoia: "d7d99294e4a9cec03e2564de8bfbff6a7e13deb0bd65f9dc0f1c252a238e2ccd"
    sha256 cellar: :any, arm64_sonoma:  "47ff8bbd289471f8b5703009d59cb0269dd1dd028f71646586598466a9fa61aa"
    sha256 cellar: :any, arm64_ventura: "59578346054df1c1060fde29159b90d3964fbec6462e77b5917d3db130077bf1"
    sha256 cellar: :any, sonoma:        "adee20f05e347bd6c3b200b16af44b46b073e1319ff49eea6daf6cd38663b099"
    sha256 cellar: :any, ventura:       "bef171dea7de12a26b1584dd149cf78d53e4c13614bcc386ea543d2c59483ede"
    sha256               x86_64_linux:  "9735013cd10088bfbe0e92ef4ff534cfe07ed5924337a06971c85ba415f59c41"
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
