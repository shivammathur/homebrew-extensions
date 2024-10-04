class Openexr < Formula
  desc "High dynamic-range image file format"
  homepage "https://www.openexr.com/"
  url "https://github.com/AcademySoftwareFoundation/openexr/archive/refs/tags/v3.3.0.tar.gz"
  sha256 "58b00f50d2012f3107573c4b7371f70516d2972c2b301a50925e1b4a60a7be6f"
  license "BSD-3-Clause"

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "3975252966c93511bd10cb56369e3d576e04c3b107d79fa54d0126c84067dc88"
    sha256 cellar: :any,                 arm64_sonoma:  "e69ceaeff7a1da39254e801541fdb9124f3eb063596b3218a80ae57f6a993b22"
    sha256 cellar: :any,                 arm64_ventura: "f3940304428ee703d5ca9e45c1480e7524fd1b4d780316b589e85fdab6d915de"
    sha256 cellar: :any,                 sonoma:        "98243512ea405b594d31d98787ac95b3fa89b06e950325c6742ad69ecbc6d9b0"
    sha256 cellar: :any,                 ventura:       "05f5c17a741f9fdedfacaf812e6c1ec940eb72bf2bd9b2000996348bde725193"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "18df0af78679bb1b9e344670f793d540cb8945b2411b16c794a728f9cbf459ac"
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

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    resource "homebrew-exr" do
      url "https://github.com/AcademySoftwareFoundation/openexr-images/raw/f17e353fbfcde3406fe02675f4d92aeae422a560/TestImages/AllHalfValues.exr"
      sha256 "eede573a0b59b79f21de15ee9d3b7649d58d8f2a8e7787ea34f192db3b3c84a4"
    end

    resource("homebrew-exr").stage do
      system bin/"exrheader", "AllHalfValues.exr"
    end
  end
end
