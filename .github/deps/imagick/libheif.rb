class Libheif < Formula
  desc "ISO/IEC 23008-12:2017 HEIF file format decoder and encoder"
  homepage "https://www.libde265.org/"
  url "https://github.com/strukturag/libheif/releases/download/v1.17.1/libheif-1.17.1.tar.gz"
  sha256 "97d74c58a346887c1bbf98dcf0322c13b728286153d0f1be2b350f7107e49dba"
  license "LGPL-3.0-only"

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "57be87707e32bfc4419667c6027b762d26995512ab8f7a34f155d65db373373a"
    sha256 cellar: :any,                 arm64_ventura:  "b26c8b665bdb45b0f2c23fd87f1995977a931f96386fd5fd43ae923f313a2466"
    sha256 cellar: :any,                 arm64_monterey: "828bfa4622f893800fba5e156f8775f67735dc857c23054fffcb5f7badb62b32"
    sha256 cellar: :any,                 sonoma:         "e8e4dfbf09c37e7d7ac0212ab16179cd4651d8c4705e90a9652efcc6db9f59ab"
    sha256 cellar: :any,                 ventura:        "0f446b9d09be4aa8511fe27a7ed33df5f34a04b73337a9aa9d3dec444056b80d"
    sha256 cellar: :any,                 monterey:       "a002e12f6c67ae1e9751126b750a6b36d2ebb074a86a78472d4cd1bbbf5b98a2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1fa6446083abcd6d9a38c5e8e1bc3e6405e37a118615ad12c5be67fa4c8196c4"
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
