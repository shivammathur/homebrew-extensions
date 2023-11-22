class Libheif < Formula
  desc "ISO/IEC 23008-12:2017 HEIF file format decoder and encoder"
  homepage "https://www.libde265.org/"
  url "https://github.com/strukturag/libheif/releases/download/v1.17.5/libheif-1.17.5.tar.gz"
  sha256 "38ab01938ef419dbebb98346dc0b1c8bb503a0449ea61a0e409a988786c2af5b"
  license "LGPL-3.0-only"

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "d047c84b7bfc2c91ddca733c29489383bfe9e9099d101852d5fcd45e572441cd"
    sha256 cellar: :any,                 arm64_ventura:  "31c25dafa9a92508e8b10d86e75cb98758e122065df309273e7b6a872720574e"
    sha256 cellar: :any,                 arm64_monterey: "bbb4c064e029cd6211165dd2077e0411f008ae313b562df6cd97d4a797e49f29"
    sha256 cellar: :any,                 sonoma:         "60ea703d780fd4ac490edda9417b58c6aa6b9fad73a7ebf3390b09bbd74a6d48"
    sha256 cellar: :any,                 ventura:        "29dbf95213b540567e0ab2872f05e8c258465626f6b5a19b18b7da1913956864"
    sha256 cellar: :any,                 monterey:       "3d48131a14e73c92847be12002b7e9656c1384d8c961b35b4a4a609555cd54df"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a37f7bb9fc21eb8e1b890a64945bcc6552dcadd273333db31f603c7415bb4f37"
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
    args = %W[
      -DWITH_RAV1E=OFF
      -DWITH_DAV1D=OFF
      -DWITH_SvtEnc=OFF
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    pkgshare.install "examples/example.heic"
    pkgshare.install "examples/example.avif"
    system "cmake", "-S", ".", "-B", "static", *args, *std_cmake_args, "-DBUILD_SHARED_LIBS=OFF"
    system "cmake", "--build", "static"
    lib.install "static/libheif/libheif.a"
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
