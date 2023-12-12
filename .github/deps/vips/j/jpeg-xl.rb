class JpegXl < Formula
  desc "New file format for still image compression"
  homepage "https://jpeg.org/jpegxl/index.html"
  url "https://github.com/libjxl/libjxl/archive/refs/tags/v0.8.2.tar.gz"
  sha256 "c70916fb3ed43784eb840f82f05d390053a558e2da106e40863919238fa7b420"
  license "BSD-3-Clause"
  revision 1

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "3fe93ccc4ec136f0ec9a426b83cca576c1004f36787336bd14602e77a4ded4af"
    sha256 cellar: :any,                 arm64_ventura:  "f4b1a2518dfff2af63cb8a05f7d0ba1bebdddd9a34aaca2b651b54aa913118ce"
    sha256 cellar: :any,                 arm64_monterey: "5a3afec55510d752d97618852d4e0cfa591fe43ed55e0c3ff328739baeca2b65"
    sha256 cellar: :any,                 arm64_big_sur:  "dfb413003b3ecd2f703b7298362b3cfcb3228e8ee5c71861d6e7c40a85c21fda"
    sha256 cellar: :any,                 sonoma:         "1093ba2170cf9fe8da1d29beed93bd1fbd196de886a5d5b8827a9c4e256f5312"
    sha256 cellar: :any,                 ventura:        "8691c33bbe7aada85c86e7ceabc4397ba1f6aab683ebf8af3bb46082a4ae80d4"
    sha256 cellar: :any,                 monterey:       "fcc3f2f348f9945953ca444067f333a146542ec0ff3e8898a9e5daa48aef5b82"
    sha256 cellar: :any,                 big_sur:        "b96951a962f8b82fa3db3680e8f8a03e922ae72e932ecba87d5bbf12a6a48ee1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9b30d5b5c7be91d1155dd4b1cd74e2e2836c461ae0f578d4391553e36d63b1c3"
  end

  depends_on "asciidoc" => :build
  depends_on "cmake" => :build
  depends_on "docbook-xsl" => :build
  depends_on "doxygen" => :build
  depends_on "pkg-config" => :build
  depends_on "sphinx-doc" => :build
  depends_on "pkg-config" => :test
  depends_on "brotli"
  depends_on "giflib"
  depends_on "highway"
  depends_on "imath"
  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "little-cms2"
  depends_on "openexr"
  depends_on "webp"

  uses_from_macos "libxml2" => :build
  uses_from_macos "libxslt" => :build # for xsltproc

  fails_with gcc: "5"
  fails_with gcc: "6"

  # These resources are versioned according to the script supplied with jpeg-xl to download the dependencies:
  # https://github.com/libjxl/libjxl/tree/v#{version}/third_party
  resource "sjpeg" do
    url "https://github.com/webmproject/sjpeg.git",
        revision: "868ab558fad70fcbe8863ba4e85179eeb81cc840"
  end

  # Upstream fixes for older macOS, remove for the next version.
  # See https://github.com/libjxl/libjxl/issues/2461#issuecomment-1813388521
  patch :DATA

  def install
    ENV.append_path "XML_CATALOG_FILES", HOMEBREW_PREFIX/"etc/xml/catalog"
    resources.each { |r| r.stage buildpath/"third_party"/r.name }
    system "cmake", "-S", ".", "-B", "build",
                    "-DJPEGXL_FORCE_SYSTEM_BROTLI=ON",
                    "-DJPEGXL_FORCE_SYSTEM_LCMS2=ON",
                    "-DJPEGXL_FORCE_SYSTEM_HWY=ON",
                    "-DJPEGXL_ENABLE_JNI=OFF",
                    "-DJPEGXL_ENABLE_SKCMS=OFF",
                    "-DJPEGXL_VERSION=#{version}",
                    "-DJPEGXL_ENABLE_MANPAGES=ON",
                    "-DCMAKE_INSTALL_RPATH=#{rpath}",
                    "-DPython_EXECUTABLE=#{Formula["asciidoc"].libexec/"bin/python"}",
                    "-DPython3_EXECUTABLE=#{Formula["asciidoc"].libexec/"bin/python3"}",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--build", "build", "--target", "install"
  end

  test do
    system "#{bin}/cjxl", test_fixtures("test.jpg"), "test.jxl"
    assert_predicate testpath/"test.jxl", :exist?

    (testpath/"jxl_test.c").write <<~EOS
      #include <jxl/encode.h>
      #include <stdlib.h>

      int main()
      {
          JxlEncoder* enc = JxlEncoderCreate(NULL);
          if (enc == NULL) {
            return EXIT_FAILURE;
          }
          JxlEncoderDestroy(enc);
          return EXIT_SUCCESS;
      }
    EOS
    jxl_flags = shell_output("pkg-config --cflags --libs libjxl").chomp.split
    system ENV.cc, "jxl_test.c", *jxl_flags, "-o", "jxl_test"
    system "./jxl_test"

    (testpath/"jxl_threads_test.c").write <<~EOS
      #include <jxl/thread_parallel_runner.h>
      #include <stdlib.h>

      int main()
      {
          void* runner = JxlThreadParallelRunnerCreate(NULL, 1);
          if (runner == NULL) {
            return EXIT_FAILURE;
          }
          JxlThreadParallelRunnerDestroy(runner);
          return EXIT_SUCCESS;
      }
    EOS
    jxl_threads_flags = shell_output("pkg-config --cflags --libs libjxl_threads").chomp.split
    system ENV.cc, "jxl_threads_test.c", *jxl_threads_flags, "-o", "jxl_threads_test"
    system "./jxl_threads_test"
  end
end
__END__
diff --git a/lib/jxl/enc_fast_lossless.cc b/lib/jxl/enc_fast_lossless.cc
index e646dbc..492e31f 100644
--- a/lib/jxl/enc_fast_lossless.cc
+++ b/lib/jxl/enc_fast_lossless.cc
@@ -30,6 +30,18 @@
 #elif (defined(__x86_64__) || defined(_M_X64)) && !defined(_MSC_VER)
 #include <immintrin.h>
 
+// manually add _mm512_cvtsi512_si32 definition if missing
+// (e.g. with Xcode on macOS Mojave)
+// copied from gcc 11.1.0 include/avx512fintrin.h line 14367-14373
+#if defined(__clang__) &&                                           \
+    ((!defined(__apple_build_version__) && __clang_major__ < 10) || \
+     (defined(__apple_build_version__) && __apple_build_version__ < 12000032))
+inline int __attribute__((__gnu_inline__, __always_inline__, __artificial__)) _mm512_cvtsi512_si32(__m512i __A) {
+  __v16si __B = (__v16si)__A;
+  return __B[0];
+}
+#endif
+
 // TODO(veluca): MSVC support for dynamic dispatch.
 #if defined(__clang__) || defined(__GNUC__)
 
@@ -39,7 +51,10 @@
 
 #ifndef FJXL_ENABLE_AVX512
 // On clang-7 or earlier, and gcc-10 or earlier, AVX512 seems broken.
-#if (defined(__clang__) && __clang_major__ > 7) || \
+#if (defined(__clang__) &&                                             \
+         (!defined(__apple_build_version__) && __clang_major__ > 7) || \
+     (defined(__apple_build_version__) &&                              \
+      __apple_build_version__ > 10010046)) ||                          \
     (defined(__GNUC__) && __GNUC__ > 10)
 #define FJXL_ENABLE_AVX512 1
 #endif
diff --git a/lib/jxl/image.cc b/lib/jxl/image.cc
index 70f3ba6..0bccbf2 100644
--- a/lib/jxl/image.cc
+++ b/lib/jxl/image.cc
@@ -111,7 +111,10 @@ void PlaneBase::InitializePadding(const size_t sizeof_t, Padding padding) {
 
   for (size_t y = 0; y < ysize_; ++y) {
     uint8_t* JXL_RESTRICT row = static_cast<uint8_t*>(VoidRow(y));
-#if defined(__clang__) && (__clang_major__ <= 6)
+#if defined(__clang__) &&                                           \
+    ((!defined(__apple_build_version__) && __clang_major__ <= 6) || \
+     (defined(__apple_build_version__) &&                           \
+      __apple_build_version__ <= 10001145))
     // There's a bug in msan in clang-6 when handling AVX2 operations. This
     // workaround allows tests to pass on msan, although it is slower and
     // prevents msan warnings from uninitialized images.
