class Harfbuzz < Formula
  desc "OpenType text shaping engine"
  homepage "https://github.com/harfbuzz/harfbuzz"
  url "https://github.com/harfbuzz/harfbuzz/archive/refs/tags/11.0.0.tar.gz"
  sha256 "85178b78f0e405269bbc0c17a55545708d86dae63a85f04cd29f71dd422879a8"
  license "MIT"
  head "https://github.com/harfbuzz/harfbuzz.git", branch: "main"

  bottle do
    sha256 cellar: :any, arm64_sequoia: "fadf32f00d2da38370d6e85f1a5055568350790b4bcee351fcfa607cec7c8f5d"
    sha256 cellar: :any, arm64_sonoma:  "73a608b029703378f8f0d3e0f2cc0918b4234c2df5e157081bfa1313253ab39e"
    sha256 cellar: :any, arm64_ventura: "882b5a6900690c6bcc30936ad93d9c7e16ebeeb5c04c0b19d523916ef20d9fc4"
    sha256 cellar: :any, sonoma:        "e926030ed7dd66ab59f5e2cc9102e76e44ab9452dab95b4db2548327547d319f"
    sha256 cellar: :any, ventura:       "74223cd0c8b7de5075168b35491aa9ae15047d493ca3aaf9278458964152e152"
    sha256               arm64_linux:   "73c0535f530a52aa53b155addb0cb4242abec4343e0b983568e093cd028b7efd"
    sha256               x86_64_linux:  "ac9eebb0f5352e66a3d0b4ada83b4a6fe3ca89f0bf17cf90626fc45d1693ba4d"
  end

  depends_on "gobject-introspection" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  depends_on "python@3.13" => [:build, :test]
  depends_on "pygobject3" => :test
  depends_on "cairo"
  depends_on "freetype"
  depends_on "glib"
  depends_on "graphite2"
  depends_on "icu4c@77"

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

    system "meson", "setup", "build", *args, *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    resource("homebrew-test-ttf").stage do
      shape = pipe_output("#{bin}/hb-shape 270b89df543a7e48e206a2d830c0e10e5265c630.ttf", "സ്റ്റ്").chomp
      assert_equal "[glyph201=0+1183|U0D4D=0+0]", shape
    end
    system "python3.13", "-c", "from gi.repository import HarfBuzz"
  end
end
