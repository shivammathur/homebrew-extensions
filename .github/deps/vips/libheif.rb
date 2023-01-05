class Libheif < Formula
  desc "ISO/IEC 23008-12:2017 HEIF file format decoder and encoder"
  homepage "https://www.libde265.org/"
  url "https://github.com/strukturag/libheif/releases/download/v1.14.1/libheif-1.14.1.tar.gz"
  sha256 "0634646587454f95e9638ca472a37321aa519fca2ec7405d0e02a74d7ee581db"
  license "LGPL-3.0-only"

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "56cbc3765dd790fcf08424d8d11f32dbdf2cc6789dc76d868baac0ae376c5ad3"
    sha256 cellar: :any,                 arm64_monterey: "dbd207584fdd53391aec1b7446038d790f719c3f3100fc2f29fa23f758cf2c95"
    sha256 cellar: :any,                 arm64_big_sur:  "c79e4f43f5f7ac1c6d6563b2bfe880b7b5fe2cec995c9fdb9c6aeb3de14cb418"
    sha256 cellar: :any,                 ventura:        "22eb4b6eb384cc3fe785823c5aa4d5dcd3e0932923a5a1ffd7e5525f51dc672b"
    sha256 cellar: :any,                 monterey:       "faa6366d477444751a7410309371ebfa884d52cc7db4fc3dfd18c9361428011e"
    sha256 cellar: :any,                 big_sur:        "527196af510e484ccee13f7ce3e78622187aeb520f9f3e4f73cb661d7fde3d35"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "468310f4b05d0da5d5e238aec8947e33073535b622eddc09b8dca15911b6d993"
  end

  depends_on "pkg-config" => :build
  depends_on "aom"
  depends_on "jpeg-turbo"
  depends_on "libde265"
  depends_on "libpng"
  depends_on "shared-mime-info"
  depends_on "x265"

  def install
    system "./configure", *std_configure_args, "--disable-silent-rules"
    system "make", "install"
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
