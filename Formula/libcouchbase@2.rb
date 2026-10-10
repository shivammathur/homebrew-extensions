# frozen_string_literal: true

# Couchbase client library for legacy PHP extensions.
class LibcouchbaseAT2 < Formula
  desc "C library for Couchbase"
  homepage "https://docs-archive.couchbase.com/c-sdk/2.10/start-using-sdk.html"
  url "https://packages.couchbase.com/clients/c/libcouchbase-2.10.9.tar.gz"
  sha256 "6f6450121e0208005c17f7f4cdd9258a571bb22183f0bc08f11d75c207d55d0a"
  license "Apache-2.0"
  revision 1
  compatibility_version 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "4ecc709000272c17b05869aad8a7f9341c507c21800e61f257e0e12b52fbcc4b"
    sha256 cellar: :any, arm64_tahoe:       "952a6c298f821eab792ea21653f758f67406dd211ddd5a838a00230ed5826522"
    sha256 cellar: :any, arm64_sequoia:     "7fd70af12fe3bd5908c2be507af376ab12dec0b1d513645a7fd9a3d65e43dfa2"
    sha256 cellar: :any, arm64_linux:       "5caed61e0f114e68dba502e51e90504ef08d45c6aab93251734b7ec5ddf28609"
    sha256 cellar: :any, x86_64_linux:      "b6f6952bf1cc95aa520e61cfdd5772654217b0317a82b59f7a2f88c3f1e24fe1"
  end

  keg_only :versioned_formula

  deprecate! date: "2023-01-20", because: :deprecated_upstream

  depends_on "cmake" => :build
  depends_on "libev"
  depends_on "libevent"
  depends_on "libuv"
  depends_on "openssl@4"

  def install
    inreplace "plugins/io/libuv/libuv_compat.h",
              "#define LIBUV_COMPAT_H",
              "#define LIBUV_COMPAT_H\n#ifndef EUNATCH\n#define EUNATCH EAI_FAIL\n#endif"
    mkdir "build" do
      system "cmake", "-S", "..", "-B", ".", *std_cmake_args,
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
