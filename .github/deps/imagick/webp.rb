class Webp < Formula
  desc "Image format providing lossless and lossy compression for web images"
  homepage "https://developers.google.com/speed/webp/"
  url "https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.3.0.tar.gz"
  sha256 "64ac4614db292ae8c5aa26de0295bf1623dbb3985054cb656c55e67431def17c"
  license "BSD-3-Clause"
  head "https://chromium.googlesource.com/webm/libwebp.git", branch: "main"

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_ventura:  "28dcf9ddd7324057a556052ebcab2f464f5e9d08cee9d3aa420bf2bf4c7f1f1b"
    sha256 cellar: :any,                 arm64_monterey: "75ebcbe19f4cd5057cd02e171589c9d305999e38c180a8300a6647bbf1132788"
    sha256 cellar: :any,                 arm64_big_sur:  "0f44d3ad129eb35d06017d3049b6253baab054315f8f5aad6e634554fc4d6a78"
    sha256 cellar: :any,                 ventura:        "ee7abe4b2abdadf7e4e326b6944956946897cb063b26e62ab025980c19ab28d7"
    sha256 cellar: :any,                 monterey:       "b4085af67d946e79e4c6a0e27334c8eecf65a00485f9327da64475e9167faae2"
    sha256 cellar: :any,                 big_sur:        "1e6d47fbd075f9ed5934f8edb69a56582788c151c9396aefe63aa18101cc867b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "13845dd9434be5f6641b53a8dae60f8bfa9e494f69234260829dd17387d6f92f"
  end

  depends_on "cmake" => :build
  depends_on "giflib"
  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "libtiff"

  def install
    args = %W[
      -DBUILD_SHARED_LIBS=ON
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"cwebp", test_fixtures("test.png"), "-o", "webp_test.png"
    system bin/"dwebp", "webp_test.png", "-o", "webp_test.webp"
    assert_predicate testpath/"webp_test.webp", :exist?
  end
end
