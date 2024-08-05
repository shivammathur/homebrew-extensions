class Libimagequant < Formula
  desc "Palette quantization library extracted from pnquant2"
  homepage "https://pngquant.org/lib/"
  url "https://github.com/ImageOptim/libimagequant/archive/refs/tags/4.3.2.tar.gz"
  sha256 "a5c00a966bba20a58a30bb0a72c1eed4bcbaea3f4eb803f3ec274a726fade06b"
  license :cannot_represent

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "a35ac5f897e523f788b85187865d465b19ed4063bbc064fe2e3f5f6319e6db84"
    sha256 cellar: :any,                 arm64_ventura:  "22f8ff2044f6f880bb1d4613be7f7e591fadc3ee2ea9818d6d51675232db2c6d"
    sha256 cellar: :any,                 arm64_monterey: "65568a5a575eabc297a59004b09fd8dcf0854dd1d0914026ca72e6e469cf6d2a"
    sha256 cellar: :any,                 sonoma:         "1a24194cccbf50fc62138218a588d9a7542ff16c38500685ef308694e99dfca1"
    sha256 cellar: :any,                 ventura:        "96c4e420ad39aae87ecdf4e4a2378a75c5ec94d2f5e9da8246925a3275962a04"
    sha256 cellar: :any,                 monterey:       "6d8afc8f9ac912e819657c47597f58d7b796204e12aec399347d70dbff6bc769"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b2b8a5a405215597bb648b80ac304607356ac1992e55955ef8239d65435bc2e1"
  end

  depends_on "cargo-c" => :build
  depends_on "rust" => :build

  def install
    cd "imagequant-sys" do
      system "cargo", "cinstall", "--prefix", prefix, "--libdir", lib
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
