class Libmatio < Formula
  desc "C library for reading and writing MATLAB MAT files"
  homepage "https://matio.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/matio/matio/1.5.25/matio-1.5.25.tar.gz"
  sha256 "5ab2762bd0f459c731641fbe7b258ebd741951652b7107176f0181bdfb548231"
  license "BSD-2-Clause"

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "f85552518024128ef04ee7c1dba2c3a6e9030317d2e3b0d0c768235f71d18173"
    sha256 cellar: :any,                 arm64_ventura:  "048e0e2343f33ef9fb1451693798a281391ce35997820d772e149c9ed3708658"
    sha256 cellar: :any,                 arm64_monterey: "8790c3843fc7269d04453f9931bd87aa28b5f2624a026d35df985c867626189a"
    sha256 cellar: :any,                 sonoma:         "9ed56ef8b0e021370b48074655fe49dc04fd8095d2026727bc3e316bf3c8616d"
    sha256 cellar: :any,                 ventura:        "93d8365b14d466694fc018415584a7b8b1e0eff33c0ca719c7b5a76d3771d82e"
    sha256 cellar: :any,                 monterey:       "766df412e9f581c34911cf69e3c86b6962d231c91207e88bea2bccda870d938d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3c0d615a0534cc34c6deca585ec6480b996a9a5944cf33eecb3d7e205f5486bb"
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
