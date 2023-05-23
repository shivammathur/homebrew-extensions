class Libheif < Formula
  desc "ISO/IEC 23008-12:2017 HEIF file format decoder and encoder"
  homepage "https://www.libde265.org/"
  url "https://github.com/strukturag/libheif/releases/download/v1.16.2/libheif-1.16.2.tar.gz"
  sha256 "7f97e4205c0bd9f9b8560536c8bd2e841d1c9a6d610401eb3eb87ed9cdfe78ea"
  license "LGPL-3.0-only"

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "bcb41390eb3a6e13e065ef2aa72671c9ead8202ffc36f685d5a7b96bdb74ce27"
    sha256 cellar: :any,                 arm64_monterey: "80fa87e104d308c55d06e0cfe6b00dbbe58b3248139510510ae7333662fa0dc7"
    sha256 cellar: :any,                 arm64_big_sur:  "c70ad78f4be96af3447671a49257e8f04516a397a7ec486fee6887dad3570f83"
    sha256 cellar: :any,                 ventura:        "27d4e1a31e9b8f4e7c311d947f1d4aa07e9cf539967463dbfac2cc8cffaabe94"
    sha256 cellar: :any,                 monterey:       "23fbc42566ee60c06f81f49c6a88b35c9051765b5da47d78ea37d92b3597ee2d"
    sha256 cellar: :any,                 big_sur:        "7797395464c4df87c20fc294dfe9aee29b7e0d9fa2fa7caa8e4cb30c88bc6c77"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7d0044ad8a8202842b5a9b7ec2527cfc69a289d98084fe1fd2fa4b3a61adfa6d"
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
