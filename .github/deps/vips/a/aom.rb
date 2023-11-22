class Aom < Formula
  desc "Codec library for encoding and decoding AV1 video streams"
  homepage "https://aomedia.googlesource.com/aom"
  url "https://aomedia.googlesource.com/aom.git",
      tag:      "v3.7.1",
      revision: "aca387522ccc0a1775716923d5489dd2d4b1e628"
  license "BSD-2-Clause"

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "946483b81ee33bc693032645a9a2154e3fcdbbec24de90013412ac830572a5ec"
    sha256 cellar: :any,                 arm64_ventura:  "bf89d707f510cebaa7c1870b428e27133b22625d7439f370c549114754335283"
    sha256 cellar: :any,                 arm64_monterey: "914c864fc1447186de3a91927b8b377d085978f12dd64cc854ae13baafd61ec5"
    sha256 cellar: :any,                 sonoma:         "6608175780bcc0054d2e21a806b87dccb5a82d16758f579a0952ae8cf382093a"
    sha256 cellar: :any,                 ventura:        "64f087cda597045332186b63709ccbb5493410ece64a394a1f7c280bdd52960d"
    sha256 cellar: :any,                 monterey:       "6d1f884b00adc0f0211389cbd833646f7f63aa601cf3bc08b2897ba646ce8dcf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1a3902c4050abd55fbe5a296724577a41a50b0684e41fdd6e30a7fdfbe4749dd"
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "jpeg-xl"
  depends_on "libvmaf"

  on_intel do
    depends_on "yasm" => :build
  end

  resource "homebrew-bus_qcif_15fps.y4m" do
    url "https://media.xiph.org/video/derf/y4m/bus_qcif_15fps.y4m"
    sha256 "868fc3446d37d0c6959a48b68906486bd64788b2e795f0e29613cbb1fa73480e"
  end

  # Fix build on arm64 macOS.
  # https://aomedia-review.googlesource.com/c/aom/+/180942
  patch :DATA

  def install
    ENV.runtime_cpu_detection

    args = [
      "-DCMAKE_INSTALL_RPATH=#{rpath}",
      "-DENABLE_DOCS=off",
      "-DENABLE_EXAMPLES=on",
      "-DENABLE_TESTDATA=off",
      "-DENABLE_TESTS=off",
      "-DENABLE_TOOLS=off",
      "-DBUILD_SHARED_LIBS=on",
      "-DCONFIG_TUNE_BUTTERAUGLI=1",
      "-DCONFIG_TUNE_VMAF=1",
    ]

    system "cmake", "-S", ".", "-B", "brewbuild", *std_cmake_args, *args
    system "cmake", "--build", "brewbuild"
    system "cmake", "--install", "brewbuild"
  end

  test do
    resource("homebrew-bus_qcif_15fps.y4m").stage do
      system "#{bin}/aomenc", "--webm",
                              "--tile-columns=2",
                              "--tile-rows=2",
                              "--cpu-used=8",
                              "--output=bus_qcif_15fps.webm",
                              "bus_qcif_15fps.y4m"

      system "#{bin}/aomdec", "--output=bus_qcif_15fps_decode.y4m",
                              "bus_qcif_15fps.webm"
    end
  end
end

__END__
diff --git a/build/cmake/aom_configure.cmake b/build/cmake/aom_configure.cmake
index 6c932e86c8..917e7cac5d 100644
--- a/build/cmake/aom_configure.cmake
+++ b/build/cmake/aom_configure.cmake
@@ -184,7 +184,9 @@ if(AOM_TARGET_CPU STREQUAL "x86" OR AOM_TARGET_CPU STREQUAL "x86_64")
   string(STRIP "${AOM_AS_FLAGS}" AOM_AS_FLAGS)
 elseif(AOM_TARGET_CPU MATCHES "arm")
   if(AOM_TARGET_SYSTEM STREQUAL "Darwin")
-    set(CMAKE_ASM_COMPILER as)
+    if(NOT CMAKE_ASM_COMPILER)
+      set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})
+    endif()
     set(AOM_AS_FLAGS -arch ${AOM_TARGET_CPU} -isysroot ${CMAKE_OSX_SYSROOT})
   elseif(AOM_TARGET_SYSTEM STREQUAL "Windows")
     if(NOT CMAKE_ASM_COMPILER)
