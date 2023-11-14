class Harfbuzz < Formula
  desc "OpenType text shaping engine"
  homepage "https://github.com/harfbuzz/harfbuzz"
  url "https://github.com/harfbuzz/harfbuzz/archive/refs/tags/8.3.0.tar.gz"
  sha256 "6a093165442348d99f3307480ea87ed83bdabaf642cdd9548cff6b329e93bfac"
  license "MIT"
  head "https://github.com/harfbuzz/harfbuzz.git", branch: "main"

  bottle do
    sha256 cellar: :any, arm64_sonoma:   "b887133a87078eaa6e1ad50d0d429a981b756c1e43fc6c16fa49b10af31b382c"
    sha256 cellar: :any, arm64_ventura:  "7a0e732036a11247848e521e4df990544415ab7810db00847231a52c4ad1093b"
    sha256 cellar: :any, arm64_monterey: "cd064abfbaf0f5e861efe9562a73a70f736eaafd269e9234ee79a05b8d4791c3"
    sha256 cellar: :any, sonoma:         "1bf9b5df00ba57b84584e03c86f44c491d34ca6c0c887c86d26afcad6df5155a"
    sha256 cellar: :any, ventura:        "ad2cd36721e732f628f1a217ea0c38696a971b31f1cddaa11a3e903dc7377dbe"
    sha256 cellar: :any, monterey:       "12047b6807717baf9fef822cc06181d21be4fd9ace801f1cb34d111c595bba00"
    sha256               x86_64_linux:   "14b087a8f369a66f82888d7cd0d10eafdf3624d292bd1374be89225fc74b5139"
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
