class Harfbuzz < Formula
  desc "OpenType text shaping engine"
  homepage "https://github.com/harfbuzz/harfbuzz"
  url "https://github.com/harfbuzz/harfbuzz/archive/8.0.1.tar.gz"
  sha256 "d54ca67b6a0bf732b66a343566446d7f93df2bb850133f886c0082fb618a06b2"
  license "MIT"
  head "https://github.com/harfbuzz/harfbuzz.git", branch: "main"

  bottle do
    sha256 cellar: :any, arm64_ventura:  "cbda47304a6ac2fe3b68153fd69ce5a7bf2bfc833f8131a5008ba4e3781c6372"
    sha256 cellar: :any, arm64_monterey: "2142378deccdefda5174b2c9d4f30b750415bcbf3ede6de7b294629390a9ef62"
    sha256 cellar: :any, arm64_big_sur:  "1f840e92d1d861c616b2ce4fee308b766d60f7381f568e6d781b5842f95c99e3"
    sha256 cellar: :any, ventura:        "6c6019132106c3b857597a6801c8148ea80c9076f09e49d189aaad99e7540fd4"
    sha256 cellar: :any, monterey:       "8f8258b80fa47aa0f86a54154541c3bea1dbe0f4c74bead3bb710038d79d3cc3"
    sha256 cellar: :any, big_sur:        "17443c5958a082927603a5994445068a12942eca6fc3c3594890ae0f7de6f82e"
    sha256               x86_64_linux:   "becbda439877a820b5c8aeec9c893fde70e231c22b5f94b267844f570026f7c4"
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
