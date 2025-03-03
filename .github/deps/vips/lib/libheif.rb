class Libheif < Formula
  desc "ISO/IEC 23008-12:2017 HEIF file format decoder and encoder"
  homepage "https://www.libde265.org/"
  url "https://github.com/strukturag/libheif/releases/download/v1.19.6/libheif-1.19.6.tar.gz"
  sha256 "d59b66d8c5a1adeb4d32438f3d0d787b91540ef90ce36f1d1619f99fddeda95b"
  license "LGPL-3.0-only"

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "f6e06fd7f1dbd258dd347c5c5501c3a100e6b68f36768733f2382a96e0b46b68"
    sha256 cellar: :any,                 arm64_sonoma:  "b89062a39b2f7cc25e884671e69f4ed567c2b6f91d4fb9c8a392a2ae077051ca"
    sha256 cellar: :any,                 arm64_ventura: "46a8927b0d06321f5364ec27e91eb0af3ae5f0769a561f67321bada9964ce101"
    sha256 cellar: :any,                 sonoma:        "1011ade91e75b48b0f75462f24334aa0f0977cb2256abf3ec0614d7f1d06d47d"
    sha256 cellar: :any,                 ventura:       "b58b96ace972108fe5521ba5a7e2545dea9d060f1779ef007d4d01d46c91abcc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "079fbe9c153e412ad185c26fce133eb98422205e3614ac1dd0a6681401dddaf9"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build

  depends_on "aom"
  depends_on "jpeg-turbo"
  depends_on "libde265"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "shared-mime-info"
  depends_on "webp"
  depends_on "x265"

  def install
    args = %W[
      -DCMAKE_INSTALL_RPATH=#{rpath}
      -DWITH_DAV1D=OFF
      -DWITH_GDK_PIXBUF=OFF
      -DWITH_RAV1E=OFF
      -DWITH_SvtEnc=OFF
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    pkgshare.install "examples/example.heic"
    pkgshare.install "examples/example.avif"

    system "cmake", "-S", ".", "-B", "static", *args, *std_cmake_args, "-DBUILD_SHARED_LIBS=OFF"
    system "cmake", "--build", "static"
    lib.install "static/libheif/libheif.a"

    # Avoid rebuilding dependents that hard-code the prefix.
    inreplace lib/"pkgconfig/libheif.pc", prefix, opt_prefix
  end

  def post_install
    system Formula["shared-mime-info"].opt_bin/"update-mime-database", "#{HOMEBREW_PREFIX}/share/mime"
  end

  test do
    output = "File contains 2 images"
    example = pkgshare/"example.heic"
    exout = testpath/"exampleheic.jpg"

    assert_match output, shell_output("#{bin}/heif-convert #{example} #{exout}")
    assert_path_exists testpath/"exampleheic-1.jpg"
    assert_path_exists testpath/"exampleheic-2.jpg"

    output = "File contains 1 image"
    example = pkgshare/"example.avif"
    exout = testpath/"exampleavif.jpg"

    assert_match output, shell_output("#{bin}/heif-convert #{example} #{exout}")
    assert_path_exists testpath/"exampleavif.jpg"
  end
end
