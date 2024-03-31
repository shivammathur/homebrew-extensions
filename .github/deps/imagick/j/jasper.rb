class Jasper < Formula
  desc "Library for manipulating JPEG-2000 images"
  homepage "https://ece.engr.uvic.ca/~frodo/jasper/"
  url "https://github.com/jasper-software/jasper/releases/download/version-4.2.3/jasper-4.2.3.tar.gz"
  sha256 "68131ddf9f62d6944cc4c58977dd177c283adb0228140b76382a2dbdadadaa4f"
  license "JasPer-2.0"

  livecheck do
    url :stable
    regex(/^version[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "b2acb59eda3d335c9855637c726bfa0e23c4775d491e2ead917bc33ea712794f"
    sha256 cellar: :any,                 arm64_ventura:  "0d8b927eb6e0db185357a55bf6f1ac8fc3c3b88f7166798a5c6841ae364518f8"
    sha256 cellar: :any,                 arm64_monterey: "2c05b419605bb213968abe13a9404bdf627ef437f1ac1ae875a10aebcad10e2c"
    sha256 cellar: :any,                 sonoma:         "87365ada63a975e02c95c2815023283d3e9d2d2de5925fea2f76ad08bbc1b173"
    sha256 cellar: :any,                 ventura:        "b0adbcd66d9b8a3ab2e0078dd66e000c66d2e9e73e2dca99730fc5d2c590dc97"
    sha256 cellar: :any,                 monterey:       "87c7f328203e74785afa9cb032fecfdaf42ee780b64c1872ec3b48e55f0a88a3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c2e3779754faa1d60692e86eb2df6d411a12aa80bed8ff464b5d6b050996988b"
  end

  depends_on "cmake" => :build
  depends_on "jpeg-turbo"

  def install
    mkdir "tmp_cmake" do
      args = std_cmake_args
      args << "-DJAS_ENABLE_DOC=OFF"

      if OS.mac?
        # Make sure macOS's GLUT.framework is used, not XQuartz or freeglut
        # Reported to CMake upstream 4 Apr 2016 https://gitlab.kitware.com/cmake/cmake/issues/16045
        glut_lib = "#{MacOS.sdk_path}/System/Library/Frameworks/GLUT.framework"
        args << "-DGLUT_glut_LIBRARY=#{glut_lib}"
      else
        args << "-DJAS_ENABLE_OPENGL=OFF"
      end

      system "cmake", "..",
        "-DJAS_ENABLE_AUTOMATIC_DEPENDENCIES=false",
        "-DJAS_ENABLE_SHARED=ON",
        *args
      system "make"
      system "make", "install"
      system "make", "clean"

      system "cmake", "..",
        "-DJAS_ENABLE_SHARED=OFF",
        *args
      system "make"
      lib.install "src/libjasper/libjasper.a"
    end
  end

  test do
    system bin/"jasper", "--input", test_fixtures("test.jpg"),
                         "--output", "test.bmp"
    assert_predicate testpath/"test.bmp", :exist?
  end
end
