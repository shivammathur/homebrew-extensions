class Libheif < Formula
  desc "ISO/IEC 23008-12:2017 HEIF file format decoder and encoder"
  homepage "https://www.libde265.org/"
  url "https://github.com/strukturag/libheif/releases/download/v1.18.2/libheif-1.18.2.tar.gz"
  sha256 "c4002a622bec9f519f29d84bfdc6024e33fd67953a5fb4dc2c2f11f67d5e45bf"
  license "LGPL-3.0-only"
  revision 1

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "ed325fb88684986ddb0e1ea928234cbcdf338532d617dd1772c942e6fb6fc523"
    sha256 cellar: :any,                 arm64_sonoma:  "fb441a4c7b0af9d301f40febc15d7e47e5c36b3dd736fa5568f6f88d664b56a3"
    sha256 cellar: :any,                 arm64_ventura: "f900c9eac6cdf2e134f9150fe61888ed279eb057efd18099245f9a326fe82a35"
    sha256 cellar: :any,                 sonoma:        "729b267c46f64bf463a96aef0b866ec41e08ee802ced4eb4f45d5bc44e8e9dd1"
    sha256 cellar: :any,                 ventura:       "3cb8608c18c3cea4cc34469c5d00a96d583980ad55e3bc2675df48754d15a0b5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8dc7b284f1a2b082fc81a2a01e6ebb1ecaec10b2f29cb1b53607dc63e8d39234"
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
