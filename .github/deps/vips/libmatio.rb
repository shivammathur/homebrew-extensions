class Libmatio < Formula
  desc "C library for reading and writing MATLAB MAT files"
  homepage "https://matio.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/matio/matio/1.5.24/matio-1.5.24.tar.gz"
  sha256 "5106ebed5b40d02a2bb968b57bef8876701c566e039e6ebe134bab779c436f7c"
  license "BSD-2-Clause"

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "7fdb99553e59b14364731f606f57595b734a4bd11dabea1872476b653c98ad05"
    sha256 cellar: :any,                 arm64_ventura:  "df25e53ed7fda850be9e40b3886f79cbcc51651cde5cf39fcaa7d7fb5aad9d3b"
    sha256 cellar: :any,                 arm64_monterey: "b9fda938a259d3093b7324aea04349f13b4cccb34498d2e107f6d9ace65e1e04"
    sha256 cellar: :any,                 sonoma:         "8d2dcb2f6c5295905c2f5286ef264c43589458bff6eb0770219b8df35e16f16a"
    sha256 cellar: :any,                 ventura:        "bfd29b1c7e452278e1ae40198b814b070572eda34537e49243a2a285dd74c124"
    sha256 cellar: :any,                 monterey:       "364a377c67718fdb897e66abde7e13e2a00234316a341732432fbfc2497ca8be"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2ff7c57c0051dd3c46ada137dac56bfc30f1d2809f7f579b4b44b347cb9dd5f0"
  end

  depends_on "pkg-config" => :test
  depends_on "hdf5"
  uses_from_macos "zlib"

  # fix pkg-config linkage for hdf5 and zlib
  patch :DATA

  def install
    args = %W[
      --enable-extended-sparse=yes
      --enable-mat73=yes
      --with-hdf5=#{Formula["hdf5"].opt_prefix}
    ]
    args << "--with-zlib=#{Formula["zlib"].opt_prefix}" unless OS.mac?

    system "./configure", *std_configure_args, *args
    system "make", "install"
  end

  test do
    resource "homebrew-test_mat_file" do
      url "https://web.uvic.ca/~monahana/eos225/poc_data.mat.sfx"
      sha256 "a29df222605476dcfa660597a7805176d7cb6e6c60413a3e487b62b6dbf8e6fe"
    end

    testpath.install resource("homebrew-test_mat_file")
    (testpath/"mat.c").write <<~EOS
      #include <stdlib.h>
      #include <matio.h>

      size_t dims[2] = {5, 5};
      double data[25] = {0.0, };
      mat_t *mat;
      matvar_t *matvar;

      int main(int argc, char **argv) {
        if (!(mat = Mat_Open(argv[1], MAT_ACC_RDONLY)))
          abort();
        Mat_Close(mat);

        mat = Mat_CreateVer("test_writenan.mat", NULL, MAT_FT_DEFAULT);
        if (mat) {
          matvar = Mat_VarCreate("foo", MAT_C_DOUBLE, MAT_T_DOUBLE, 2,
                                 dims, data, MAT_F_DONT_COPY_DATA);
          Mat_VarWrite(mat, matvar, MAT_COMPRESSION_NONE);
          Mat_VarFree(matvar);
          Mat_Close(mat);
        } else {
          abort();
        }
        mat = Mat_CreateVer("foo", NULL, MAT_FT_MAT73);
        return EXIT_SUCCESS;
      }
    EOS
    system ENV.cc, "mat.c", "-o", "mat", "-I#{include}", "-L#{lib}", "-lmatio"
    system "./mat", "poc_data.mat.sfx"

    refute_includes shell_output("pkg-config --cflags matio"), "-I/usr/include"
  end
end

__END__
diff --git a/matio.pc.in b/matio.pc.in
index 96d9402..139f11e 100644
--- a/matio.pc.in
+++ b/matio.pc.in
@@ -6,6 +6,5 @@ includedir=@includedir@
 Name: MATIO
 Description: MATIO Library
 Version: @VERSION@
-Libs: -L${libdir} -lmatio
-Cflags: -I${includedir}
-Requires.private: @HDF5_REQUIRES_PRIVATE@ @ZLIB_REQUIRES_PRIVATE@
+Libs: -L${libdir} -lmatio @HDF5_LIBS@ @ZLIB_LIBS@
+Cflags: -I${includedir} @HDF5_CFLAGS@ @ZLIB_CFLAGS@
