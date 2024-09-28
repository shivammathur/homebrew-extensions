class Hdf5 < Formula
  desc "File format designed to store large amounts of data"
  homepage "https://www.hdfgroup.org/solutions/hdf5/"
  url "https://github.com/HDFGroup/hdf5/releases/download/hdf5_1.14.4.3/hdf5-1.14.4-3.tar.gz"
  version "1.14.4.3"
  sha256 "019ac451d9e1cf89c0482ba2a06f07a46166caf23f60fea5ef3c37724a318e03"
  license "BSD-3-Clause"
  version_scheme 1

  # This regex isn't matching filenames within href attributes (as we normally
  # do on HTML pages) because this page uses JavaScript to handle the download
  # buttons and the HTML doesn't contain the related URLs.
  livecheck do
    url "https://www.hdfgroup.org/downloads/hdf5/source-code/"
    regex(/>\s*hdf5[._-]v?(\d+(?:\.\d+)+)(?:-\d+)?\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "5cc08587212e632e4ef2b8ca037d679cf011297333bfc95bd0f753b452e7b514"
    sha256 cellar: :any,                 arm64_sonoma:  "4c249b2b21f8a306715a5d35f61b83f0b9839c0335f2a5751902ff2cfef1820b"
    sha256 cellar: :any,                 arm64_ventura: "914aee87d16c9ddeaf88e00ef33db5cd4e942655c69ed91f11aac4f916dbc949"
    sha256 cellar: :any,                 sonoma:        "72da6906e4f1589d8224f878278c09b445fdd077597be4065c3efe28eec5cf29"
    sha256 cellar: :any,                 ventura:       "9b776abda0d9124d8afed04bf881521ca8ea4e9232a8bb82bf6d12209bcd4300"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fa1d18554918eee7081b17be953886f1dc250d190792eef50e7a3cc4bb7b8bc8"
  end

  depends_on "cmake" => :build
  depends_on "gcc" # for gfortran
  depends_on "libaec"
  depends_on "pkg-config"

  uses_from_macos "zlib"

  conflicts_with "hdf5-mpi", because: "hdf5-mpi is a variant of hdf5, one can only use one or the other"

  def install
    ENV["libaec_DIR"] = Formula["libaec"].opt_prefix.to_s
    args = %w[
      -DHDF5_USE_GNU_DIRS:BOOL=ON
      -DHDF5_INSTALL_CMAKE_DIR=lib/cmake/hdf5
      -DHDF5_BUILD_FORTRAN:BOOL=ON
      -DHDF5_BUILD_CPP_LIB:BOOL=ON
      -DHDF5_ENABLE_SZIP_SUPPORT:BOOL=ON
    ]

    # https://github.com/HDFGroup/hdf5/issues/4310
    args << "-DHDF5_ENABLE_NONSTANDARD_FEATURE_FLOAT16:BOOL=OFF"

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args

    # Avoid c shims in settings files
    inreplace_c_files = %w[
      build/src/H5build_settings.c
      build/src/libhdf5.settings
      build/CMakeFiles/h5cc
      build/CMakeFiles/h5hlcc
    ]
    inreplace inreplace_c_files, Superenv.shims_path/ENV.cc, ENV.cc

    # Avoid cpp shims in settings files
    inreplace_cxx_files = %w[
      build/CMakeFiles/h5c++
      build/CMakeFiles/h5hlc++
    ]
    inreplace_cxx_files << "build/src/libhdf5.settings" if OS.linux?
    inreplace inreplace_cxx_files, Superenv.shims_path/ENV.cxx, ENV.cxx

    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
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
    system bin/"h5cc", "test.c"
    assert_equal version.major_minor_patch.to_s, shell_output("./a.out").chomp

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
    system bin/"h5fc", "test.f90"
    assert_equal version.major_minor_patch.to_s, shell_output("./a.out").chomp

    # Make sure that it was built with SZIP/libaec
    config = shell_output("#{bin}/h5cc -showconfig")
    assert_match %r{I/O filters.*DECODE}, config
  end
end
