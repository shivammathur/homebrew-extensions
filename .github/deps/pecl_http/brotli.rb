class Brotli < Formula
  desc "Generic-purpose lossless compression algorithm by Google"
  homepage "https://github.com/google/brotli"
  url "https://github.com/google/brotli/archive/v1.1.0.tar.gz"
  mirror "http://fresh-center.net/linux/misc/brotli-1.1.0.tar.gz"
  mirror "http://fresh-center.net/linux/misc/legacy/brotli-1.1.0.tar.gz"
  sha256 "e720a6ca29428b803f4ad165371771f5398faba397edf6778837a18599ea13ff"
  license "MIT"
  head "https://github.com/google/brotli.git", branch: "master"

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "752bc1b5b8fe4c369afd1a7d37c5073e629f565a8ee9d8b3229e3d9e167ec734"
    sha256 cellar: :any,                 arm64_monterey: "8dbfb8fc5fecb3cf7db0b78892b0a86f72923c4192f8c2fe53031911d6ec59b6"
    sha256 cellar: :any,                 arm64_big_sur:  "a7af609813ab31e0816e7fde2510ee8b23045c1720c799bc94dfae7b8d6cc1bf"
    sha256 cellar: :any,                 ventura:        "e2ab96bd3ac33f28df4abff410639ab490f61e73f4d617c0c697d84eb65b9adb"
    sha256 cellar: :any,                 monterey:       "cf6f8a635958840ef85cae1464250454cb37fc15a84e74d3d8e3d16e578c146f"
    sha256 cellar: :any,                 big_sur:        "098ec6e1ed317b89ad799a56b9c4c4f02991b37df9ddad568720ee3c16d1d7d0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "73231d2d7656d1ff7f036ca2370b72c2203ef335f6382a0bfa5e54cfc7e11944"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "VERBOSE=1"
    system "ctest", "-V"
    system "make", "install"
  end

  test do
    (testpath/"file.txt").write("Hello, World!")
    system "#{bin}/brotli", "file.txt", "file.txt.br"
    system "#{bin}/brotli", "file.txt.br", "--output=out.txt", "--decompress"
    assert_equal (testpath/"file.txt").read, (testpath/"out.txt").read
  end
end
