class Cfitsio < Formula
  desc "C access to FITS data files with optional Fortran wrappers"
  homepage "https://heasarc.gsfc.nasa.gov/docs/software/fitsio/fitsio.html"
  url "https://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio-4.5.0.tar.gz"
  sha256 "e4854fc3365c1462e493aa586bfaa2f3d0bb8c20b75a524955db64c27427ce09"
  license "CFITSIO"

  livecheck do
    url :homepage
    regex(/href=.*?cfitsio[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "51a9f6adf5e55328d0d91199c0f5ac380e9e974a0f464c363697f371128947b3"
    sha256 cellar: :any,                 arm64_sonoma:  "9d49c196f2c9d92d91687e1300c1c881f167971afe190fbce0198206af42c0f9"
    sha256 cellar: :any,                 arm64_ventura: "2abbcb409ae95b067b962e680b9bf351248d71295dc709007dc56d16c277dfa4"
    sha256 cellar: :any,                 sonoma:        "8bdc384b9c5f40ddb0c2a56e4dede3b7d010124a3d264057e016ce4f04a6f1fd"
    sha256 cellar: :any,                 ventura:       "2f5cae21877f210e4b09cea1dd7bf25333710d53a27a1702265a08597af12067"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4f7005252adb0eecaa53ec23fe3f6d08c4505c1a1c69198c6838500bbd4c4664"
  end

  depends_on "cmake" => :build
  uses_from_macos "zlib"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
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
