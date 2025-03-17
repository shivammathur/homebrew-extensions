class Harfbuzz < Formula
  desc "OpenType text shaping engine"
  homepage "https://github.com/harfbuzz/harfbuzz"
  url "https://github.com/harfbuzz/harfbuzz/archive/refs/tags/10.4.0.tar.gz"
  sha256 "0d25a3f74af4e8744700ac19050af5a80ae330378a5802a5cd71e523bb6fda1f"
  license "MIT"
  revision 1
  head "https://github.com/harfbuzz/harfbuzz.git", branch: "main"

  bottle do
    sha256 cellar: :any, arm64_sequoia: "110ecf0994d080a3a9da34ced6589738219299458abcb0a6d01beae0b2140949"
    sha256 cellar: :any, arm64_sonoma:  "6960bca18de29e2dce132d9f3a018149c16b5f56d2b0a5d1febe8681170ddee6"
    sha256 cellar: :any, arm64_ventura: "510f3bf1ddb0a0f809f42c13ac90c75850a725ac5cf19f35816de7185386748a"
    sha256 cellar: :any, sonoma:        "5b1fe71f5e2c479ae12b6197b5190fc30c8a5875bdd4b00beaa8c0fa41329410"
    sha256 cellar: :any, ventura:       "a77edd0441bb70aa37a2157b78f6dc84d88d5f0192134b5148a5b7c86edb89e1"
    sha256               x86_64_linux:  "89de929c077bc060d96deb4c8b0cae9ebfaa20e6d15b5bb1b24a87ca1821a06e"
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
