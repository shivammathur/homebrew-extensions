class Harfbuzz < Formula
  desc "OpenType text shaping engine"
  homepage "https://github.com/harfbuzz/harfbuzz"
  url "https://github.com/harfbuzz/harfbuzz/archive/8.1.0.tar.gz"
  sha256 "8d544f1b74797b7b4d88f586e3b9202528b3e8c17968d28b7cdde02041bff5a0"
  license "MIT"
  head "https://github.com/harfbuzz/harfbuzz.git", branch: "main"

  bottle do
    sha256 cellar: :any, arm64_ventura:  "7ba6289f4a8207642d10b7144a840f395c05996e1b9f972eddfcdd020b038da4"
    sha256 cellar: :any, arm64_monterey: "af6fd58c9c436b9c8735b1bc4974c21e54bbdccf0729eed6b0cf6a88ea2592cf"
    sha256 cellar: :any, arm64_big_sur:  "3de3a20152c20a2def6cd9f08fa3fbe29641ff7aba37494b8f92c53d0181ef9a"
    sha256 cellar: :any, ventura:        "b2a101ed3f88321648125f2bda083f8a01c11e8a737999ac3c8041244bed8fde"
    sha256 cellar: :any, monterey:       "2ecea6d541a105c71b0e21b2d83c71ae3f3137dc3a24346f5ce45bed0da160b1"
    sha256 cellar: :any, big_sur:        "12cf97861f63a80c23c888d6be1226668c6dfcf4b0fcf1f8e007ed53660313a0"
    sha256               x86_64_linux:   "f506dba507761a037752a2ed4640b7359674559863d643814dabb7d0ef273248"
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
