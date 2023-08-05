class Openexr < Formula
  desc "High dynamic-range image file format"
  homepage "https://www.openexr.com/"
  url "https://github.com/AcademySoftwareFoundation/openexr/archive/v3.1.10.tar.gz"
  sha256 "6e0fd3f0eb1cb907bd3593830ea2b3431b85f22a6f18f99f8cfa099fec70067d"
  license "BSD-3-Clause"

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "7c713dfcd55b24ed89cbb6371b6e83a00ae491a20e1cec1900306c0a09670529"
    sha256 cellar: :any,                 arm64_monterey: "7bc040f5aaf3513aa62f5be501cd0dff688dd0f0d7e7f9a6038dc2047820f8a0"
    sha256 cellar: :any,                 arm64_big_sur:  "c8ceecc8a5a74ac5a1affbd1151fce2443d46ad8e69aa4ec42537e3e311bdad1"
    sha256 cellar: :any,                 ventura:        "30f83b565e5a6be0f27601e0a1987fdd637c86321f8441739ea4dfa5508c11a2"
    sha256 cellar: :any,                 monterey:       "b4297d49f61c107ffa7b74c2ff01a224137d9c35db4f144f2ae9e36df7cd0230"
    sha256 cellar: :any,                 big_sur:        "3bf316a792023f9f5d6abd5de03b2c6227acc3e8e475995c133b9b7d27d938b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e1db4e91c7beaff0f78f30332a0671d815b930cc57c8752e577ab5c33913bead"
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
