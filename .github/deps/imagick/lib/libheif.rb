class Libheif < Formula
  desc "ISO/IEC 23008-12:2017 HEIF file format decoder and encoder"
  homepage "https://www.libde265.org/"
  url "https://github.com/strukturag/libheif/releases/download/v1.18.0/libheif-1.18.0.tar.gz"
  sha256 "3f25f516d84401d7c22a24ef313ae478781b95f235c250b06152701c401055c3"
  license "LGPL-3.0-only"

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "b0efee985da340e25a426537b5384760a389616bf0eba1dc4272dd405ffb5c06"
    sha256 cellar: :any,                 arm64_ventura:  "78d957ad18f2aa8f39785696e247f534a3135e6857f1fe06397ef4cf3fad6b46"
    sha256 cellar: :any,                 arm64_monterey: "b1bc760191176e842f1e08edcfda33b7b321621d766407bff76a40743e147c3c"
    sha256 cellar: :any,                 sonoma:         "2a4a38dffe19b46aecaaa86a7b0ad46c10cde35adfef2464959143aeee2883a7"
    sha256 cellar: :any,                 ventura:        "6b481808a5c154021db6ff7bc70cc8904c287b6ef1ce0f51a564e27674a11e40"
    sha256 cellar: :any,                 monterey:       "03cc40324e701982afea52a3778ed78d5f82182a1d4e645204e84955ce54a595"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cdfd803d389037975ade70683646bb91363711bc3802d0e6bfbfaefb657c94b2"
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
