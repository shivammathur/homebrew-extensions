class Harfbuzz < Formula
  desc "OpenType text shaping engine"
  homepage "https://github.com/harfbuzz/harfbuzz"
  url "https://github.com/harfbuzz/harfbuzz/archive/refs/tags/10.1.0.tar.gz"
  sha256 "c758fdce8587641b00403ee0df2cd5d30cbea7803d43c65fddd76224f7b49b88"
  license "MIT"
  head "https://github.com/harfbuzz/harfbuzz.git", branch: "main"

  bottle do
    sha256 cellar: :any, arm64_sequoia: "442fc5e12f48a14b44402b3f291d2e08b303e540654465875c67e881909f69e2"
    sha256 cellar: :any, arm64_sonoma:  "e9f6cd76f2e41e47cbe68dbac40090588e0131914c204d4ac5b6c496eed7e072"
    sha256 cellar: :any, arm64_ventura: "fcd6245c5056a3e173c76124f05dfa919f08677b3058b9ade36cd63b538ee840"
    sha256 cellar: :any, sonoma:        "ecfa08a551e6f66f6c58616bc88772b868a7897b346fa6b8111b7c21f89c00d6"
    sha256 cellar: :any, ventura:       "d93cb96159f682fa7f5106205f1f8a754661efbabbe49fdb11cf3af41147980b"
    sha256               x86_64_linux:  "4960b5d596b1935ac47f63749b995c7b21a9cf8bdfcb8d72c6335da306e1b243"
  end

  depends_on "gobject-introspection" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "python@3.13" => [:build, :test]
  depends_on "pygobject3" => :test
  depends_on "cairo"
  depends_on "freetype"
  depends_on "glib"
  depends_on "graphite2"
  depends_on "icu4c@76"

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
    system "python3.13", "-c", "from gi.repository import HarfBuzz"
  end
end
