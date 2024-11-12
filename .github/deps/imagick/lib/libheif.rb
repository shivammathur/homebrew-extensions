class Libheif < Formula
  desc "ISO/IEC 23008-12:2017 HEIF file format decoder and encoder"
  homepage "https://www.libde265.org/"
  url "https://github.com/strukturag/libheif/releases/download/v1.19.3/libheif-1.19.3.tar.gz"
  sha256 "1e6d3bb5216888a78fbbf5fd958cd3cf3b941aceb002d2a8d635f85cc59a8599"
  license "LGPL-3.0-only"

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "3bba2eed59bb0073ef058222fc3a130ae0ce6d93c69f48655c4a749b0587743a"
    sha256 cellar: :any,                 arm64_sonoma:  "dacdaaf5421f0f89d5fe8ecd99e95905daf70ad31ede6a53bc77f2c33d671dc2"
    sha256 cellar: :any,                 arm64_ventura: "d84bc349dc1b4242cfd016076c7a40f098493c3ca350a2fcc444be7166b419b3"
    sha256 cellar: :any,                 sonoma:        "6ab96e8a54de72e8b599c5e931560e52909f6706abb5a0f996856285175f0636"
    sha256 cellar: :any,                 ventura:       "0a6ae4df76da6138e1baa7edb79be89447ca8911c2f0081e91e53bc76d71b638"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ff3a7253f7e2369a09ece3574e7f8918af8eb007bf5f5cb8d9be9296ae6110bc"
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

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
