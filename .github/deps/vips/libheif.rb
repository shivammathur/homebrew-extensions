class Libheif < Formula
  desc "ISO/IEC 23008-12:2017 HEIF file format decoder and encoder"
  homepage "https://www.libde265.org/"
  url "https://github.com/strukturag/libheif/releases/download/v1.16.1/libheif-1.16.1.tar.gz"
  sha256 "ac15b54b6d7c315710e156d119b8a1bfc89f29621e99222b2750b1f31c9c3558"
  license "LGPL-3.0-only"

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "9e5b80ff35c0de49c4a1f4fb0ae42881dc075d8c1afc1ec2d59601ac2c4b31c8"
    sha256 cellar: :any,                 arm64_monterey: "2a0e5562d1803fcfc402eabdb0472d35fe44b62cbb60ffbb1ddb061335744e58"
    sha256 cellar: :any,                 arm64_big_sur:  "b467241ead10c66bd29e6ef48f1dc3c7a42dca1bb350b88301b55233da96042e"
    sha256 cellar: :any,                 ventura:        "6d28c99852064c37f490811b24bb1d41d8e58ac5c81e68fc37ab0834e1b1d9f6"
    sha256 cellar: :any,                 monterey:       "1c84e79aae796ade62f244a9f4336cb1614391999160cce7ef6430ca4bdee022"
    sha256 cellar: :any,                 big_sur:        "5ed7e83a3529da5f816a719aebba8083cc26c3bf1d4e8c2e895009a66eba0c05"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "235eb9d5170ff6527eda668830a859551575fefad05d6f3f69d62b365f6969b2"
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "aom"
  depends_on "jpeg-turbo"
  depends_on "libde265"
  depends_on "libpng"
  depends_on "shared-mime-info"
  depends_on "x265"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DCMAKE_INSTALL_RPATH=#{rpath}"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    pkgshare.install "examples/example.heic"
    pkgshare.install "examples/example.avif"
  end

  def post_install
    system Formula["shared-mime-info"].opt_bin/"update-mime-database", "#{HOMEBREW_PREFIX}/share/mime"
  end

  test do
    output = "File contains 2 images"
    example = pkgshare/"example.heic"
    exout = testpath/"exampleheic.jpg"

    assert_match output, shell_output("#{bin}/heif-convert #{example} #{exout}")
    assert_predicate testpath/"exampleheic-1.jpg", :exist?
    assert_predicate testpath/"exampleheic-2.jpg", :exist?

    output = "File contains 1 image"
    example = pkgshare/"example.avif"
    exout = testpath/"exampleavif.jpg"

    assert_match output, shell_output("#{bin}/heif-convert #{example} #{exout}")
    assert_predicate testpath/"exampleavif.jpg", :exist?
  end
end
