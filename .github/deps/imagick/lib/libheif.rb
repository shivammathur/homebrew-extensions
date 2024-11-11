class Libheif < Formula
  desc "ISO/IEC 23008-12:2017 HEIF file format decoder and encoder"
  homepage "https://www.libde265.org/"
  url "https://github.com/strukturag/libheif/releases/download/v1.19.2/libheif-1.19.2.tar.gz"
  sha256 "f73eb786e75ef1f815ed3d37aca9eadd41dc1d26dfde11f8a4f92f911622d19e"
  license "LGPL-3.0-only"

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "49ea2b6b26a9c6850bbd09c5478316a0533a99c2559af83658beb01da42df9b0"
    sha256 cellar: :any,                 arm64_sonoma:  "dc70477bb1daae813245cbab42474216aadb2384710fd45b1ef04557ae7e8010"
    sha256 cellar: :any,                 arm64_ventura: "7edaf722b52739c798f14be2d926bb5a44bbcca17ee442bef882469dfe1fc918"
    sha256 cellar: :any,                 sonoma:        "e4225e4404b37f238b38f5d6baaf19181b971826aef5cfad119412f63a99d358"
    sha256 cellar: :any,                 ventura:       "a01a8cdee32b9d024db53c5d037e7f6cea662bd41166095401c0fb075605551c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4e31a49f56504d7f499793ae18e9d224326bd7555aa62af73cbc535e81819773"
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

  # Fix to api error for 'cannot assign to non-static data member'
  # apply upstream patch and should check for removal on next release
  patch do
    url "https://github.com/strukturag/libheif/commit/3dd7019ff579c038cba96353390cd41edfda927e.patch?full_index=1"
    sha256 "9397a8b1b92f311eb1f9bf5c1bae4f5244a406556fd0ce91b3caed7a91daa0d0"
  end

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
