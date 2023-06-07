class Openexr < Formula
  desc "High dynamic-range image file format"
  homepage "https://www.openexr.com/"
  url "https://github.com/AcademySoftwareFoundation/openexr/archive/v3.1.8.tar.gz"
  sha256 "3ff47111ef7e5da6f69330e66e1e90ae620b79df1cedf2512bb9bffe86c2c617"
  license "BSD-3-Clause"

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "cf3c67469dc5e115d6eee92ac03ab714682c2c92bc4c9e4e651646e26d8ab01d"
    sha256 cellar: :any,                 arm64_monterey: "8127a2654786828c421a71d09f0c8d466448470f37c4cba509e5f8f0a0584680"
    sha256 cellar: :any,                 arm64_big_sur:  "60c7ec52379a19267ecb4759fa79187d2a87c2f1a9dba992875608ae07cc5461"
    sha256 cellar: :any,                 ventura:        "5e764ee26219abb137867b73b583fc3fb6d26e1edc147e6b175259710918141e"
    sha256 cellar: :any,                 monterey:       "ad8ba45a13187cd9a7d736c91fc39de941dd4a61f9e2e5c78e08e2fc2f0d0fd2"
    sha256 cellar: :any,                 big_sur:        "a58d9b7548104519a268131d54d405e2d9434672cbaaef0f9282d2db0139d49f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bdba05e38f5282abcbdd41f2cb772f342e84bfab363de4a56d3d197c74b44b94"
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "imath"

  uses_from_macos "zlib"

  # These used to be provided by `ilmbase`
  link_overwrite "include/OpenEXR"
  link_overwrite "lib/libIex.dylib"
  link_overwrite "lib/libIex.so"
  link_overwrite "lib/libIlmThread.dylib"
  link_overwrite "lib/libIlmThread.so"

  resource "homebrew-exr" do
    url "https://github.com/AcademySoftwareFoundation/openexr-images/raw/f17e353fbfcde3406fe02675f4d92aeae422a560/TestImages/AllHalfValues.exr"
    sha256 "eede573a0b59b79f21de15ee9d3b7649d58d8f2a8e7787ea34f192db3b3c84a4"
  end

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    resource("homebrew-exr").stage do
      system bin/"exrheader", "AllHalfValues.exr"
    end
  end
end
