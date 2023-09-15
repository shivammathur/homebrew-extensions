class Harfbuzz < Formula
  desc "OpenType text shaping engine"
  homepage "https://github.com/harfbuzz/harfbuzz"
  url "https://github.com/harfbuzz/harfbuzz/archive/8.2.0.tar.gz"
  sha256 "ca9d6c49b0eb100d343a984abeb3aa332443df48aa2ae0f2c78cf2e72c01ef78"
  license "MIT"
  head "https://github.com/harfbuzz/harfbuzz.git", branch: "main"

  bottle do
    sha256 cellar: :any, arm64_sonoma:   "57efd64e9f9cc2fe839e757a01094a16d15dd634adb33ad358ffe10e3505f90c"
    sha256 cellar: :any, arm64_ventura:  "2571adc31981a21dafcea5712c9855602cad834f68011adc5ed66a4625e0b724"
    sha256 cellar: :any, arm64_monterey: "3e60d5c11c68c4afc0eb4ae2b9a532186161e8fbaaaddc2c43a71dbd31b76f75"
    sha256 cellar: :any, arm64_big_sur:  "ccf270ef6e3215a5d621d83971d085e7d7109a9d319bfa56c7a57dc396d26df6"
    sha256 cellar: :any, sonoma:         "9961e4712a7bf70a8a0ecb8328e52eaf766b377dec3a7d5079beec6e0f64b122"
    sha256 cellar: :any, ventura:        "74602d8e980e202c01ec58604b7be94f03ed87916fe55fcbe6a997f22e5499e8"
    sha256 cellar: :any, monterey:       "f97d87260bab1a08d1edbbc3a8b2dbedd6a06bd3dabf20407ce68e8d9f86cda0"
    sha256 cellar: :any, big_sur:        "e6f98584725e1ddcbe8535f5940fb75568d591cea9f888d484bab379392e912b"
    sha256               x86_64_linux:   "45bad5e8ee923a72baab9c49c1c2daa7d135de99c9bd18b5b6f3a4a592e9ca4a"
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
