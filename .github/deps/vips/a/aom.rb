class Aom < Formula
  desc "Codec library for encoding and decoding AV1 video streams"
  homepage "https://aomedia.googlesource.com/aom"
  url "https://aomedia.googlesource.com/aom.git",
      tag:      "v3.8.0",
      revision: "b681eac83963950afc7be55df56c22fa5210aaa2"
  license "BSD-2-Clause"
  revision 2

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "4f1ffd5a5e4f7ca84f5e59a8cbd85320f963a6d2cfcda375163e854c8b202a80"
    sha256 cellar: :any,                 arm64_ventura:  "8d5e157d688ce99ba5078a2021f269ebc603089c7c5ee2c19ebe311626bc9963"
    sha256 cellar: :any,                 arm64_monterey: "bd118dde35192603412ddd1f8c2da3677b03287780d543e828a3566691c29383"
    sha256 cellar: :any,                 sonoma:         "302e6660697f101f28f0c345c592e38773e1cd53d7cb216efe79f209f26ee854"
    sha256 cellar: :any,                 ventura:        "002bda2d195541c3f7413097f6d67f219e4e29cddf415eb9146b3178d8fa4612"
    sha256 cellar: :any,                 monterey:       "63df4b3621997f240e686f5ce233ca757bbb02b9e75edb7f6975b6e15e054572"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "06bec413b397a4f30c0d65d1704751adf0438de7d6a9ad064ae8d859d7e485c0"
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
