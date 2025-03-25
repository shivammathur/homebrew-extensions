class Cfitsio < Formula
  desc "C access to FITS data files with optional Fortran wrappers"
  homepage "https://heasarc.gsfc.nasa.gov/docs/software/fitsio/fitsio.html"
  url "https://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio-4.6.0.tar.gz"
  sha256 "7c372fdb4e6cf530fc12294ae0b7f1fdd0ed85062790277a60aea56c97b0d3e7"
  license "CFITSIO"
  revision 1

  livecheck do
    url :homepage
    regex(/href=.*?cfitsio[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "b4840688dc91e1514e9bba00d75ad9e088cc476012d049b05dcea30d7bf2581f"
    sha256 cellar: :any,                 arm64_sonoma:  "1c7bf77712a66f86836db494facd0cb55e83b594ace4a4d388f299dfbfae748a"
    sha256 cellar: :any,                 arm64_ventura: "0fa68eef595ebf1ea0eae32355e5cae294871dad772bff5195e0b5442cd70941"
    sha256 cellar: :any,                 sonoma:        "a465c14b5ea65fca7768f799cc69498cbc31804e399042e9cd240dfd360606bc"
    sha256 cellar: :any,                 ventura:       "39745c769ea7b54bbddc7295d1f0d5ea02cb1fd91c8c1115eac57cdc9166e9c5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b96aa1cfd42ccbaef7d954af47fd13975599d7a44fc672094357d5fe834f9839"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "95ac322ee873ba55a36b861712b04728f450a9395444969e0cf5f6ec12d2df27"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :test
  uses_from_macos "zlib"

  def install
    # Incorporates upstream commits:
    #   https://github.com/HEASARC/cfitsio/commit/8ea4846049ba89e5ace4cc03d7118e8b86490a7e
    #   https://github.com/HEASARC/cfitsio/commit/6aee9403917f8564d733938a6baa21b9695da442
    # Review for removal in next release
    inreplace "cfitsio.pc.cmake" do |f|
      f.sub!(/exec_prefix=.*/, "exec_prefix=${prefix}")
      f.sub!(/libdir=.*/, "libdir=${exec_prefix}/@CMAKE_INSTALL_LIBDIR@")
      f.sub!(/includedir=.*/, "includedir=${prefix}/@CMAKE_INSTALL_INCLUDEDIR@")
    end

    args = %W[
      -DCMAKE_INSTALL_RPATH=#{rpath}
      -DCMAKE_INSTALL_INCLUDEDIR=include
      -DUSE_PTHREADS=ON
      -DTESTS=OFF
    ]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    (pkgshare/"testprog").install Dir["testprog*", "utilities/testprog.c"]
  end

  test do
    cp Dir["#{pkgshare}/testprog/testprog*"], testpath
    flags = shell_output("pkg-config --cflags --libs #{name}").split
    system ENV.cc, "testprog.c", "-o", "testprog", *flags
    system "./testprog > testprog.lis"
    cmp "testprog.lis", "testprog.out"
    cmp "testprog.fit", "testprog.std"
  end
end
