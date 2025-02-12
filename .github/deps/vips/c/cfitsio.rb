class Cfitsio < Formula
  desc "C access to FITS data files with optional Fortran wrappers"
  homepage "https://heasarc.gsfc.nasa.gov/docs/software/fitsio/fitsio.html"
  url "https://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio-4.5.0.tar.gz"
  sha256 "e4854fc3365c1462e493aa586bfaa2f3d0bb8c20b75a524955db64c27427ce09"
  license "CFITSIO"
  revision 1

  livecheck do
    url :homepage
    regex(/href=.*?cfitsio[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "f75cf3efeae1f14e2f2a0e9bd613589b54b234d1f62d070cdf7655a664cefdc2"
    sha256 cellar: :any,                 arm64_sonoma:  "5b409af1b20a62e3cf0ac4b28d98710587fef00cedf2f0bcc15c5d9bd4495c1c"
    sha256 cellar: :any,                 arm64_ventura: "6a810dabb0c64415cbd0d60fd14a7a0b1c9b778b03dacd5dd8c4a16e1b838be0"
    sha256 cellar: :any,                 sonoma:        "7bb2a07deb32043204d42936bae06e59f6b05b35c5b692c756cc424d9d245a55"
    sha256 cellar: :any,                 ventura:       "c2527d9855893cf751c2042b1f1ddc5e8ecc5cb3ccdbac007ffb36ed53510e3d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "90f174222a9f4dbc222ae1edee97a9dab1dc905cd37c2cdc3590dd60979250d9"
  end

  depends_on "cmake" => :build
  uses_from_macos "zlib"

  # Fix pkg-config file location, should be removed on next release
  patch do
    url "https://github.com/HEASARC/cfitsio/commit/d2828ae5af42056bb4fde397f3205479d01a4cf1.patch?full_index=1"
    sha256 "690d0bde53fc276f53b9a3f5d678ca1d03280fae7cfa84e7b59b87304fcdcb46"
  end

  def install
    system "cmake", "-S", ".", "-B", "build", "-DUSE_PTHREADS=ON", *std_cmake_args
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
