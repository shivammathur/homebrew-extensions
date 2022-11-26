class Harfbuzz < Formula
  desc "OpenType text shaping engine"
  homepage "https://github.com/harfbuzz/harfbuzz"
  url "https://github.com/harfbuzz/harfbuzz/archive/5.3.1.tar.gz"
  sha256 "77c8c903f4539b050a6d3a5be79705c7ccf7b1cb66d68152a651486e261edbd2"
  license "MIT"
  head "https://github.com/harfbuzz/harfbuzz.git", branch: "main"

  bottle do
    rebuild 1
    sha256 cellar: :any, arm64_ventura:  "d4e91ccdbfeb4b1ff203ecf5576e6b1378e5583c8df63482856fb302b3bcbe1c"
    sha256 cellar: :any, arm64_monterey: "469ab0b63c782e98514493a4f70ac6202298af815abe6f7fa9f8facf44247550"
    sha256 cellar: :any, arm64_big_sur:  "e6ec119055a076145cdf6c6a440cd5d57a8d81a7f91b988e7bd020993a267332"
    sha256 cellar: :any, ventura:        "8c545e7d68fa90b70c7004521b81f3e15005f2021919fd3ead6d61b934ec762a"
    sha256 cellar: :any, monterey:       "38b0743c9e1b989ef9e5b724c3a99ec25c34bd56c8c43ec51e803e81d93f50ce"
    sha256 cellar: :any, big_sur:        "faf83eb7fdd6f2ea498274676ac7152656cacab6af7217a9b09875e7127a8de8"
    sha256 cellar: :any, catalina:       "385447700d9f6f09f5042eabafecfafdffb56a09d14cde9ce895c6dce569afb5"
    sha256               x86_64_linux:   "497155424dc4d4cf0b801efe0ee85f0af6fb5a603d309f7db88bc4b2e47c0570"
  end

  depends_on "gobject-introspection" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
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
