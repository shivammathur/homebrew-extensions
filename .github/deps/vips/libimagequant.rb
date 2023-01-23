class Libimagequant < Formula
  desc "Palette quantization library extracted from pnquant2"
  homepage "https://pngquant.org/lib/"
  url "https://github.com/ImageOptim/libimagequant/archive/4.1.0.tar.gz"
  sha256 "7673521655cdf0ec16b99fd0c7c8b1bd542b6f3a8469fa2effe34b0f53e9fa92"
  license :cannot_represent

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "83b8ea0a2654c6a2516712ece9e20208770ff90fa324e03997d1fe8b0f65871e"
    sha256 cellar: :any,                 arm64_monterey: "454d43fd2a4c42e9e3780c81ef782df385da6505697b558da2fccf84efa33f64"
    sha256 cellar: :any,                 arm64_big_sur:  "9bfaedff0014059564b7e2c5374cf17c8631066cc62f135a649407423721a241"
    sha256 cellar: :any,                 ventura:        "f9edeb668fae55c96cb47dd40f6a5202b9398fa98d3db18c60897fe6f28ad0ec"
    sha256 cellar: :any,                 monterey:       "d70767ef60a95d6dea38969cc1642c58c8f099fcab9fc2b26fb4ceff03427333"
    sha256 cellar: :any,                 big_sur:        "5180ace5cdca80ad9f3300bc9cd1f63507d8d63f9984636309ca1dc037cd46e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b7388b36eff0c17d18765a2a474a9163fd50515e81a222a33e4482bc8aa3035b"
  end

  depends_on "cargo-c" => :build
  depends_on "rust" => :build

  def install
    cd "imagequant-sys" do
      system "cargo", "cinstall", "--prefix", prefix
    end
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <libimagequant.h>

      int main()
      {
        liq_attr *attr = liq_attr_create();
        if (!attr) {
          return 1;
        } else {
          liq_attr_destroy(attr);
          return 0;
        }
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-limagequant", "-o", "test"
    system "./test"
  end
end
