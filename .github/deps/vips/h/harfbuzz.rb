class Harfbuzz < Formula
  desc "OpenType text shaping engine"
  homepage "https://github.com/harfbuzz/harfbuzz"
  url "https://github.com/harfbuzz/harfbuzz/archive/refs/tags/8.2.2.tar.gz"
  sha256 "0546aac7b2493b3681047914550860157f8799fc80bf5cb528927a9643d6ab3d"
  license "MIT"
  head "https://github.com/harfbuzz/harfbuzz.git", branch: "main"

  bottle do
    sha256 cellar: :any, arm64_sonoma:   "ddf11a7bb71aec8283bb98afb89d83aef967849c92bc4e0e2d3c53fc2f05912a"
    sha256 cellar: :any, arm64_ventura:  "741b8c4acc9fdee9815c619f7347fa66d63fc33ad8f515e856ea26df723ae0e7"
    sha256 cellar: :any, arm64_monterey: "7e7b3e6e445929d6745697cc5c5435a45753253a850d47dfc616a0008ebc429c"
    sha256 cellar: :any, sonoma:         "67f5e5ccdddab3fe657c6408e1eb7c8d354e5d8a6f6ec091f4376f03183ea7a4"
    sha256 cellar: :any, ventura:        "7bca78a0f0c6737111547eff586b31ea63a35593234ce5093a9129aa9c997b0f"
    sha256 cellar: :any, monterey:       "649392d9a148bd35aa1acbc8933dcb6ad13914aa28a6aa6248d407975f445260"
    sha256               x86_64_linux:   "5de5c517257950521f3c98e5c6e70149b244650982c3526470b47794c8394fec"
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

  # remove for next release
  patch do
    url "https://github.com/harfbuzz/harfbuzz/commit/821d52a2665cd339722cfdede47d8c6ecb99fac7.patch?full_index=1"
    sha256 "a25b5c51ac283fffea4da97f4166e2a724d03ae3f1e073ce7b1092f7dc617210"
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
