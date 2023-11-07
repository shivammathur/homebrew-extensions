class Cfitsio < Formula
  desc "C access to FITS data files with optional Fortran wrappers"
  homepage "https://heasarc.gsfc.nasa.gov/docs/software/fitsio/fitsio.html"
  url "https://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio-4.3.0.tar.gz"
  sha256 "fdadc01d09cf9f54253802c5ec87eb10de51ce4130411415ae88c30940621b8b"
  license "CFITSIO"

  livecheck do
    url :homepage
    regex(/href=.*?cfitsio[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "512da2f12edecd29892ac66e2207f5536f1798ab1c9e808298098e38b1bc003e"
    sha256 cellar: :any,                 arm64_ventura:  "58e178434c58d120cbed1fed0edfd3596c469c9128a37c3bd13e577539560227"
    sha256 cellar: :any,                 arm64_monterey: "d0f78706ba8f9b1def5514aa9147d6e50f1259a1e25ce8fc926e36cb86f276d1"
    sha256 cellar: :any,                 sonoma:         "4cbcbb7e0aa8ff812e637cce6e63b1f72bbf159559daaedf2d4bfef37ebb56d7"
    sha256 cellar: :any,                 ventura:        "34daf8cbc11f092ac0257788ea20d1687b8ab23b7753791d8715915763924d3c"
    sha256 cellar: :any,                 monterey:       "e1e2d890fd310cc13bcb0d9c84dae055f1ab318e939c5eeae4c2b2cc9c63d91a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bbc06552483533da9056a7937ffdf24109e149da043cd69d0a519614e00657f4"
  end

  uses_from_macos "zlib"

  def install
    system "./configure", "--prefix=#{prefix}", "--enable-reentrant"
    system "make", "shared"
    system "make", "fpack"
    system "make", "funpack"
    system "make", "install"
    (pkgshare/"testprog").install Dir["testprog*"]
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
