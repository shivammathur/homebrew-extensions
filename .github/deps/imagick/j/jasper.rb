class Jasper < Formula
  desc "Library for manipulating JPEG-2000 images"
  homepage "https://ece.engr.uvic.ca/~frodo/jasper/"
  url "https://github.com/jasper-software/jasper/releases/download/version-4.1.2/jasper-4.1.2.tar.gz"
  sha256 "22392e439b87c79aaf8689ec79a286a7147e811c4bee34edf3d0b239798d672b"
  license "JasPer-2.0"

  livecheck do
    url :stable
    regex(/^version[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "7449ea338eac0a4f131ecfa103dd7ff72065952e69da7f968f2018d07f382154"
    sha256 cellar: :any,                 arm64_ventura:  "aeed0829e7b2e7365f7eb7edb74b79f8311d4cbb6690369ffb1ab10b7a8cc82c"
    sha256 cellar: :any,                 arm64_monterey: "c2a6d2c2305494f5a6c2b322bcd427e24fcd48da90794518034ba2bb0579bce2"
    sha256 cellar: :any,                 sonoma:         "aa96ecd9424de0b78ceb6423e3910563b44206ba15f2bbe4ce4bb30e5bc2abc4"
    sha256 cellar: :any,                 ventura:        "e247ea768bf8c96681956938babf236730b68162483517049efe72b2b828bbc6"
    sha256 cellar: :any,                 monterey:       "22b9e7d00037a9e5ea8f1f13a8f78e2beaa280d5db53aebf10cfab7149927445"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8f4d8bf148ead2eee5784354caa170ab6f38194ec9415e1c6b6ed434c461cb2b"
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
