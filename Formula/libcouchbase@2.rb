class LibcouchbaseAT2 < Formula
  desc "C library for Couchbase"
  homepage "https://docs-archive.couchbase.com/c-sdk/2.10/start-using-sdk.html"
  url "https://packages.couchbase.com/clients/c/libcouchbase-2.10.9.tar.gz"
  sha256 "6f6450121e0208005c17f7f4cdd9258a571bb22183f0bc08f11d75c207d55d0a"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "4acf9f80c58ecbff26f918ee0a113e8fb25ca8f03c0e14c5368caacc76c9f24d"
    sha256 cellar: :any,                 arm64_sonoma:   "1f934247cd79b9f5e3b079a06ef6145c5fd02c51de8afab62dabbd9d3bd2a352"
    sha256 cellar: :any,                 arm64_ventura:  "799566d704fb9e8d7277c1f19ffc664cb5442741710ec88aa66ac3d56a9bd1ef"
    sha256 cellar: :any,                 arm64_monterey: "ae6fdeb94c99edb5c3c50382156b09797f66532c2ea8013c46f93eaa2c1b5873"
    sha256 cellar: :any,                 ventura:        "506f65dc0a5fbba7bf525246e35c85ac1ed0e3247e3d583745998bf20bda345d"
    sha256 cellar: :any,                 monterey:       "a985878bc9d2cc015b6396c12415aaf95a0b01304c7c8df3d787457a2cfb2f7b"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "e3dc2799128204f2d3d22ff73cfe7a3355dd5c440b8a99345548f63added8a59"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7a3ea448f4813e623c8ad0ff2491ca6b77961e6d03bccfb4c5d43391903e3472"
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
                            "-DLCB_BUILD_LIBUV=ON",
                            "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
      system "make", "install"
    end
  end

  test do
    assert_match "LCB_ECONNREFUSED",
      shell_output("#{bin}/cbc cat document_id -U couchbase://localhost:1 2>&1", 1).strip
  end
end
