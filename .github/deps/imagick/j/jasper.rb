class Jasper < Formula
  desc "Library for manipulating JPEG-2000 images"
  homepage "https://ece.engr.uvic.ca/~frodo/jasper/"
  url "https://github.com/jasper-software/jasper/releases/download/version-4.1.1/jasper-4.1.1.tar.gz"
  sha256 "03ba86823f8798f3f60a5a34e36f3eff9e9cbd76175643a33d4aac7c0390240a"
  license "JasPer-2.0"

  livecheck do
    url :stable
    regex(/^version[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "dfa0d78ad1cbe3920650842419b4f10abf267eff25eda5e295ab84c2f22e5115"
    sha256 cellar: :any,                 arm64_ventura:  "a1782bd7c31e4959504de079450ac1b640b81e0b7a457702e62582540b4a0c66"
    sha256 cellar: :any,                 arm64_monterey: "0e2e4b38df2491a002860311c16ae61f0fa59f97a6542796283f25f82e3b806c"
    sha256 cellar: :any,                 sonoma:         "11d4301ca1b8691d23d11c64d23e1dc230e41a0e60b9b3022f61a0c84d3e1571"
    sha256 cellar: :any,                 ventura:        "76eaf7a4073f54defc9672c6e448e6623884f3c1416943f9f5e56a78588fb0bb"
    sha256 cellar: :any,                 monterey:       "3e94d76d894b2373fe1884ac6ce83066a1e7d3b421822dc2e08c28ff056751c6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "391f861732d76bc74573bfce2ed062bc5ce403c65a291b8351041933afaf284a"
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
