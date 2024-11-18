class Libheif < Formula
  desc "ISO/IEC 23008-12:2017 HEIF file format decoder and encoder"
  homepage "https://www.libde265.org/"
  url "https://github.com/strukturag/libheif/releases/download/v1.19.3/libheif-1.19.3.tar.gz"
  sha256 "1e6d3bb5216888a78fbbf5fd958cd3cf3b941aceb002d2a8d635f85cc59a8599"
  license "LGPL-3.0-only"

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "dd0280b46fc9f2a96513f84fecc39f33bcbf63c2d66bb4c499f88fcc4d732205"
    sha256 cellar: :any,                 arm64_sonoma:  "fd766246f75d32c9ac7cde63d5ad3461acdd3b0dc4e0ccc9adffaa71d0493dce"
    sha256 cellar: :any,                 arm64_ventura: "4a0fff7327682a50ec5f3d02f2417d9cf51a0ada7796e85ef55571f8e611ede1"
    sha256 cellar: :any,                 sonoma:        "f164e3c4c16433d67114da8648b385737754727614d204b253ecd3a90caf63eb"
    sha256 cellar: :any,                 ventura:       "886a527680d9f16b774dd32121b9dea3dc248290ab0874b7120ae46dfbaf311a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "16cc60c0af4787d7f943e19204122cf8d6f8132e84ec9cf008dd3f0f070314d3"
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
    assert_predicate testpath/"exampleheic-1.jpg", :exist?
    assert_predicate testpath/"exampleheic-2.jpg", :exist?

    output = "File contains 1 image"
    example = pkgshare/"example.avif"
    exout = testpath/"exampleavif.jpg"

    assert_match output, shell_output("#{bin}/heif-convert #{example} #{exout}")
    assert_predicate testpath/"exampleavif.jpg", :exist?
  end
end
