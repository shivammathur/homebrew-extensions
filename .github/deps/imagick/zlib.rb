class Zlib < Formula
  desc "General-purpose lossless data-compression library"
  homepage "https://zlib.net/"
  url "https://zlib.net/zlib-1.2.12.tar.gz"
  mirror "https://downloads.sourceforge.net/project/libpng/zlib/1.2.12/zlib-1.2.12.tar.gz"
  mirror "http://fresh-center.net/linux/misc/zlib-1.2.12.tar.gz"
  mirror "http://fresh-center.net/linux/misc/legacy/zlib-1.2.12.tar.gz"
  sha256 "91844808532e5ce316b3c010929493c0244f3d37593afd6de04f71821d5136d9"
  license "Zlib"
  revision 1
  head "https://github.com/madler/zlib.git", branch: "develop"

  livecheck do
    url :homepage
    regex(/href=.*?zlib[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_monterey: "4dcbd4731daf497739f5536769e774c75f7154c81b61275cc604bf3a96f86de4"
    sha256 cellar: :any,                 arm64_big_sur:  "1e5c3a20d301c1025d5372c537674ceb2c5d9c571850de9a45302fa177e56a62"
    sha256 cellar: :any,                 monterey:       "bdfd57b2672b1e75df424d19acbba962ec6c377e759aad5ae9d59ba85a4f603d"
    sha256 cellar: :any,                 big_sur:        "fe7b0bb374b53124357a455583c07cffd730e44487c7547a62fd972c9da58d1c"
    sha256 cellar: :any,                 catalina:       "52031d7d56f77a64b9a8674988b4f1080239eab37c4f2635f31ea01180ad12c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c8e13538da9684a2cd591d241ea9a2ca6d6761b15a685dbf38c8a8fe9e0a42ea"
  end

  keg_only :provided_by_macos

  # https://zlib.net/zlib_how.html
  resource "test_artifact" do
    url "https://zlib.net/zpipe.c"
    version "20051211"
    sha256 "68140a82582ede938159630bca0fb13a93b4bf1cb2e85b08943c26242cf8f3a6"
  end

  # Patch for configure issue
  # Remove with the next release
  patch do
    url "https://github.com/madler/zlib/commit/05796d3d8d5546cf1b4dfe2cd72ab746afae505d.patch?full_index=1"
    sha256 "68573842f1619bb8de1fa92071e38e6e51b8df71371e139e4e96be19dd7e9694"
  end

  # Patch for CRC compatibility issue
  # Remove with the next release
  patch do
    url "https://github.com/madler/zlib/commit/ec3df00224d4b396e2ac6586ab5d25f673caa4c2.patch?full_index=1"
    sha256 "c7d1cbb58b144c48b7fa8b52c57531e9fd80ab7d87c5d58ba76a9d33c12cb047"
  end

  # Patch for CVE-2022-37434
  # Remove with the next release
  patch do
    url "https://github.com/madler/zlib/commit/eff308af425b67093bab25f80f1ae950166bece1.patch?full_index=1"
    sha256 "b6d631860d5d02e3261c0e5c06ba598fb82fa64995ba527861c6c18542eca05c"
  end

  # Amendment of the above patch to fix a segfault
  # Remove with the next release
  patch do
    url "https://github.com/madler/zlib/commit/1eb7682f845ac9e9bf9ae35bbfb3bad5dacbd91d.patch?full_index=1"
    sha256 "5483f1e4cad801bdaff948e1092f1e8de892e5ee817bf371c69a5d5f20d27b27"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    testpath.install resource("test_artifact")
    system ENV.cc, "zpipe.c", "-I#{include}", "-L#{lib}", "-lz", "-o", "zpipe"

    touch "foo.txt"
    output = "./zpipe < foo.txt > foo.txt.z"
    system output
    assert_predicate testpath/"foo.txt.z", :exist?
  end
end
