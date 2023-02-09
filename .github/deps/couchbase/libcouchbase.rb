class Libcouchbase < Formula
  desc "C library for Couchbase"
  homepage "https://docs.couchbase.com/c-sdk/current/hello-world/start-using-sdk.html"
  url "https://packages.couchbase.com/clients/c/libcouchbase-3.3.4.tar.gz"
  sha256 "73fdc518b06920bbfee0043ea265aaeeb78c23ed2e655819a1d3905605a3867c"
  license "Apache-2.0"
  head "https://github.com/couchbase/libcouchbase.git", branch: "master"

  bottle do
    sha256 arm64_ventura:  "aca8e99ae5c372a927daa9aab9ca195e7f10bda9c2a57e8dff23bc4691671731"
    sha256 arm64_monterey: "31e173b7aae3b5e8d640afaa2aab5371724c14c46aed9cbd44f883a20099ec7a"
    sha256 arm64_big_sur:  "14e7d186966147e49fc5481799b9fd0ab8f2f571fb18e62c930806f192b93f0a"
    sha256 ventura:        "9ac0a7fcee1d0a9326089ae9a2101c9221066843f6cb63ce3122dd8d2b5c8593"
    sha256 monterey:       "585993af4d28e48a2c849e6d48268a3643ffb417b78b8121e0b94f733c8e0fb0"
    sha256 big_sur:        "f7e0ce38ba1d3344c8f30e33a8c564b9da5875e4d26bb16768f6e4b91d22c762"
    sha256 x86_64_linux:   "05a2da02ea8cbf58c8edf345b36f53329cafc6c1fcafd8427701863d04bad0f4"
  end

  depends_on "cmake" => :build
  depends_on "libev"
  depends_on "libevent"
  depends_on "libuv"
  depends_on "openssl@1.1"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args,
                            "-DLCB_NO_TESTS=1",
                            "-DLCB_BUILD_LIBEVENT=ON",
                            "-DLCB_BUILD_LIBEV=ON",
                            "-DLCB_BUILD_LIBUV=ON"
      system "make", "install"
    end
  end

  test do
    assert_match "LCB_ERR_CONNECTION_REFUSED",
      shell_output("#{bin}/cbc cat document_id -U couchbase://localhost:1 2>&1", 1).strip
  end
end
