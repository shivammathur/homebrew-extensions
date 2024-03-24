class LibcouchbaseAT2 < Formula
  desc "C library for Couchbase"
  homepage "https://docs-archive.couchbase.com/c-sdk/2.10/start-using-sdk.html"
  url "https://packages.couchbase.com/clients/c/libcouchbase-2.10.9.tar.gz"
  sha256 "6f6450121e0208005c17f7f4cdd9258a571bb22183f0bc08f11d75c207d55d0a"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
  end

  keg_only :versioned_formula

  deprecate! date: "2023-01-20", because: :deprecated_upstream

  depends_on "cmake" => :build
  depends_on "libev"
  depends_on "libevent"
  depends_on "libuv"
  depends_on "openssl@3"

  def install
    inreplace "plugins/io/libuv/libuv_compat.h",
              "#define LIBUV_COMPAT_H",
              "#define LIBUV_COMPAT_H\n#ifndef EUNATCH\n#define EUNATCH EAI_FAIL\n#endif"
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
    assert_match "LCB_ECONNREFUSED",
      shell_output("#{bin}/cbc cat document_id -U couchbase://localhost:1 2>&1", 1).strip
  end
end
