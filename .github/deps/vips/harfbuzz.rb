class Harfbuzz < Formula
  desc "OpenType text shaping engine"
  homepage "https://github.com/harfbuzz/harfbuzz"
  url "https://github.com/harfbuzz/harfbuzz/archive/8.0.0.tar.gz"
  sha256 "a8e8ec6f0befce0bd5345dd741d2f88534685a798002e343a38b7f9b2e00c884"
  license "MIT"
  head "https://github.com/harfbuzz/harfbuzz.git", branch: "main"

  bottle do
    sha256 cellar: :any, arm64_ventura:  "ff8d0fb5f3ca65a5ed9028427529cf4d875c2419bd3d75291ee9d08b5081be19"
    sha256 cellar: :any, arm64_monterey: "7e0d5d0814f08788a1c6f4a7725b45ea929bfba4a1f0de039a6641afe2b25f18"
    sha256 cellar: :any, arm64_big_sur:  "c0bf45eb1a7774e852b4a895fefb41f6ebc1bebf3ab72b64ee74b78ea44a4dd5"
    sha256 cellar: :any, ventura:        "51c19e76f3a68ae21a351f94b98e52d80608e70dcf3d12b2e0d7cab9c8dd7ded"
    sha256 cellar: :any, monterey:       "0a18bd09ddfcf00e2beeb86ac253008288f7d88ad758591125e5925cf3885b98"
    sha256 cellar: :any, big_sur:        "dc5174be00bcfbd70ed1b93ac0cc70cef1635861e84062d31fa604bb2344f3a3"
    sha256               x86_64_linux:   "80423d81b010db5734304d14db35dfc71a60693d42373b4bd03938e1f08a3f0d"
  end

  depends_on "gobject-introspection" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "python@3.11" => [:build, :test]
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
    system "python3.11", "-c", "from gi.repository import HarfBuzz"
  end
end
