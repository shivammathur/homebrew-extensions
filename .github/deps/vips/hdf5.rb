class Hdf5 < Formula
  desc "File format designed to store large amounts of data"
  homepage "https://www.hdfgroup.org/HDF5"
  url "https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.14/hdf5-1.14.0/src/hdf5-1.14.0.tar.bz2"
  sha256 "e4e79433450edae2865a4c6328188bb45391b29d74f8c538ee699f0b116c2ba0"
  license "BSD-3-Clause"
  version_scheme 1

  # This regex isn't matching filenames within href attributes (as we normally
  # do on HTML pages) because this page uses JavaScript to handle the download
  # buttons and the HTML doesn't contain the related URLs.
  livecheck do
    url "https://www.hdfgroup.org/downloads/hdf5/source-code/"
    regex(/>\s*hdf5[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "2b724d9683b91b525cc7a964b8794dc58fd4cca77145c2ecca97a28a2df214ae"
    sha256 cellar: :any,                 arm64_monterey: "3db7396cb7c1eb060308b67fe5dfe5468054cfbb2e93c07084479197d36f1183"
    sha256 cellar: :any,                 arm64_big_sur:  "1ce80fc076f265c4693869d580bfd57ea445aaad3d3dff3d590964f153e3e35d"
    sha256 cellar: :any,                 ventura:        "c14b662746e206b7691248256b91a759c6878ec271da7a5ae740da146addbd3f"
    sha256 cellar: :any,                 monterey:       "c4fd6bc74aef6489c545fed8e271df900e19f4ea430cea5a86b58b8f5d27ce77"
    sha256 cellar: :any,                 big_sur:        "6a63399687425fc49793edc211e276c43aa8c97db01793eb5d76dc61c0a46d37"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f76358615d3138e3fef97717303bb02ba1694230639776df175dbda0d4b51bd3"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "gcc" # for gfortran
  depends_on "libaec"

  uses_from_macos "zlib"

  conflicts_with "hdf5-mpi", because: "hdf5-mpi is a variant of hdf5, one can only use one or the other"

  # Fixes buildpath references in install, remove in next release
  # https://github.com/HDFGroup/hdf5/commit/02c68739745887cd17b840a7e91d2ec9c9008bb1
  patch :DATA

  def install
    inreplace %w[c++/src/h5c++.in fortran/src/h5fc.in bin/h5cc.in],
              "${libdir}/libhdf5.settings",
              "#{pkgshare}/libhdf5.settings"

    inreplace "src/Makefile.am",
              "settingsdir=$(libdir)",
              "settingsdir=#{pkgshare}"

    system "autoreconf", "--force", "--install", "--verbose"

    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-build-mode=production
      --enable-fortran
      --enable-cxx
      --prefix=#{prefix}
      --with-szlib=#{Formula["libaec"].opt_prefix}
    ]
    args << "--with-zlib=#{Formula["zlib"].opt_prefix}" if OS.linux?

    system "./configure", *args

    # Avoid shims in settings file
    inreplace "src/libhdf5.settings", Superenv.shims_path/ENV.cxx, ENV.cxx
    inreplace "src/libhdf5.settings", Superenv.shims_path/ENV.cc, ENV.cc

    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include "hdf5.h"
      int main()
      {
        printf("%d.%d.%d\\n", H5_VERS_MAJOR, H5_VERS_MINOR, H5_VERS_RELEASE);
        return 0;
      }
    EOS
    system "#{bin}/h5cc", "test.c"
    assert_equal version.to_s, shell_output("./a.out").chomp

    (testpath/"test.f90").write <<~EOS
      use hdf5
      integer(hid_t) :: f, dspace, dset
      integer(hsize_t), dimension(2) :: dims = [2, 2]
      integer :: error = 0, major, minor, rel

      call h5open_f (error)
      if (error /= 0) call abort
      call h5fcreate_f ("test.h5", H5F_ACC_TRUNC_F, f, error)
      if (error /= 0) call abort
      call h5screate_simple_f (2, dims, dspace, error)
      if (error /= 0) call abort
      call h5dcreate_f (f, "data", H5T_NATIVE_INTEGER, dspace, dset, error)
      if (error /= 0) call abort
      call h5dclose_f (dset, error)
      if (error /= 0) call abort
      call h5sclose_f (dspace, error)
      if (error /= 0) call abort
      call h5fclose_f (f, error)
      if (error /= 0) call abort
      call h5close_f (error)
      if (error /= 0) call abort
      CALL h5get_libversion_f (major, minor, rel, error)
      if (error /= 0) call abort
      write (*,"(I0,'.',I0,'.',I0)") major, minor, rel
      end
    EOS
    system "#{bin}/h5fc", "test.f90"
    assert_equal version.to_s, shell_output("./a.out").chomp
  end
end
__END__
diff --git a/configure.ac b/configure.ac
index 8e406f71af..7b1d10c014 100644
--- a/configure.ac
+++ b/configure.ac
@@ -3012,8 +3012,7 @@ SUBFILING_VFD=no
 HAVE_MERCURY="no"
 
 ## Always include subfiling directory so public header files are available
-CPPFLAGS="$CPPFLAGS -I$ac_abs_confdir/src/H5FDsubfiling"
-AM_CPPFLAGS="$AM_CPPFLAGS -I$ac_abs_confdir/src/H5FDsubfiling"
+H5_CPPFLAGS="$H5_CPPFLAGS -I$ac_abs_confdir/src/H5FDsubfiling"
 
 AC_MSG_CHECKING([if the subfiling I/O virtual file driver (VFD) is enabled])
 
@@ -3061,8 +3060,7 @@ if test "X$SUBFILING_VFD" = "Xyes"; then
     mercury_dir="$ac_abs_confdir/src/H5FDsubfiling/mercury"
     mercury_inc="$mercury_dir/src/util"
 
-    CPPFLAGS="$CPPFLAGS -I$mercury_inc"
-    AM_CPPFLAGS="$AM_CPPFLAGS -I$mercury_inc"
+    H5_CPPFLAGS="$H5_CPPFLAGS -I$mercury_inc"
 
     HAVE_STDATOMIC_H="yes"
     AC_CHECK_HEADERS([stdatomic.h],,[HAVE_STDATOMIC_H="no"])
