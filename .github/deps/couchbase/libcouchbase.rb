class Libcouchbase < Formula
  desc "C library for Couchbase"
  homepage "https://docs.couchbase.com/c-sdk/current/hello-world/start-using-sdk.html"
  url "https://packages.couchbase.com/clients/c/libcouchbase-3.3.6.tar.gz"
  sha256 "3c2029ae06e4b84ea6c8ed99636ce918e965eb702cbc4a326b19d23bdef725d9"
  license "Apache-2.0"
  head "https://github.com/couchbase/libcouchbase.git", branch: "master"

  bottle do
    sha256 arm64_ventura:  "1de2c75def3dd56e37beb86f466cff79ba6ca35e15ded56d3dd42961acf22553"
    sha256 arm64_monterey: "4f42739a0ebb51b21194fc997a4d5f131993b97cdd9bbf6431f8b67c9395840f"
    sha256 arm64_big_sur:  "8d5053266f32ff50caa22fd28c8405be989937e3f95564fc8101992867e2f244"
    sha256 ventura:        "48c0ee9d0003f903ae296afb8b1812f6f51edddf27378e7b41b6a3b95a101f4f"
    sha256 monterey:       "5c74af87e1acd807becfc26a8f69e2fa9ed7840f6e8796d96221aafe012e2ae1"
    sha256 big_sur:        "f263fc6282e31432ab2e7f7f97f69bb008acebdb000213517b061da514636d70"
    sha256 x86_64_linux:   "3b1a34a2184b254bb37049096daabc1806466332879ffbbe66da35e95584e42b"
  end

  depends_on "cmake" => :build
  depends_on "libev"
  depends_on "libevent"
  depends_on "libuv"
  depends_on "openssl@1.1"

  def install
    system "cmake", "-S", ".", "-B", "build",
                    "-DLCB_NO_TESTS=1",
                    "-DLCB_BUILD_LIBEVENT=ON",
                    "-DLCB_BUILD_LIBEV=ON",
                    "-DLCB_BUILD_LIBUV=ON",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "LCB_ERR_CONNECTION_REFUSED",
      shell_output("#{bin}/cbc cat document_id -U couchbase://localhost:1 2>&1", 1).strip
  end
end
