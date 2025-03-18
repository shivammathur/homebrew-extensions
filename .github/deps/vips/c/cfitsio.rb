class Cfitsio < Formula
  desc "C access to FITS data files with optional Fortran wrappers"
  homepage "https://heasarc.gsfc.nasa.gov/docs/software/fitsio/fitsio.html"
  url "https://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio-4.6.0.tar.gz"
  sha256 "7c372fdb4e6cf530fc12294ae0b7f1fdd0ed85062790277a60aea56c97b0d3e7"
  license "CFITSIO"

  livecheck do
    url :homepage
    regex(/href=.*?cfitsio[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "0a2282e52cea1554ded11bf20b8ccb08c4797b841cbd2cab36a630060039d384"
    sha256 cellar: :any,                 arm64_sonoma:  "a34fdd4b5953b49582eaaf3096640c9b1125fa5efc7654996d8c0efddb6c4089"
    sha256 cellar: :any,                 arm64_ventura: "6518ed062c9fbdad59543f94dfc3e0075c408f9630f70f43c09ec49c5a3a2648"
    sha256 cellar: :any,                 sonoma:        "5dfcb63aace71db6811b9ef614bc4e96e739f09c6359addaa2f357097c9c7035"
    sha256 cellar: :any,                 ventura:       "e49c70a730a4e19450da1d7f370ea5f016acb3274544332b54195fa9d7c2a4b9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "76ab7cd815f1ef133e79644620f101acc45e236a6e2d9857f6af1a00518af6e2"
  end

  depends_on "cmake" => :build
  uses_from_macos "zlib"

  def install
    args = %W[
      -DCMAKE_INSTALL_RPATH=#{rpath}
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
    system ENV.cc, "testprog.c", "-o", "testprog", "-I#{include}",
                   "-L#{lib}", "-lcfitsio"
    system "./testprog > testprog.lis"
    cmp "testprog.lis", "testprog.out"
    cmp "testprog.fit", "testprog.std"
  end
end
