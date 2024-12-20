class Protobuf < Formula
  desc "Protocol buffers (Google's data interchange format)"
  homepage "https://protobuf.dev/"
  url "https://github.com/protocolbuffers/protobuf/releases/download/v29.2/protobuf-29.2.tar.gz"
  sha256 "63150aba23f7a90fd7d87bdf514e459dd5fe7023fdde01b56ac53335df64d4bd"
  license "BSD-3-Clause"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "ebdc813a570e07256ae4cbbccb7f957dcdf4c0082549d9411c3809da28e5ab67"
    sha256 cellar: :any,                 arm64_sonoma:  "a40fe3294d6e8db62041ed9069ab85109c3e871388d4d0abad033985b464a15a"
    sha256 cellar: :any,                 arm64_ventura: "82a4e56471237d6b632467c73af0047dc3906a133b02472327637b9b059ee339"
    sha256 cellar: :any,                 sonoma:        "ba008b98bfc8107a374c3b66d38b642cc18902efb3d199d023e1ddfca910384e"
    sha256 cellar: :any,                 ventura:       "cce92b30d8fa10b0f394e935dd3134f8291cbb97b85b6f7a72fa24325351ffe3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d09b3643a53347af743b1703f33a8a8829ba3e567f2da13f5c81f337c082dfac"
  end

  depends_on "cmake" => :build
  depends_on "abseil"
  uses_from_macos "zlib"

  on_macos do
    # We currently only run tests on macOS.
    # Running them on Linux requires rebuilding googletest with `-fPIC`.
    depends_on "googletest" => :build
  end

  # Backport to expose java-related symbols
  patch do
    url "https://github.com/protocolbuffers/protobuf/commit/9dc5aaa1e99f16065e25be4b9aab0a19bfb65ea2.patch?full_index=1"
    sha256 "edc1befbc3d7f7eded6b7516b3b21e1aa339aee70e17c96ab337f22e60e154d7"
  end

  def install
    # Keep `CMAKE_CXX_STANDARD` in sync with the same variable in `abseil.rb`.
    abseil_cxx_standard = 17
    cmake_args = %W[
      -DCMAKE_CXX_STANDARD=#{abseil_cxx_standard}
      -DBUILD_SHARED_LIBS=ON
      -Dprotobuf_BUILD_LIBPROTOC=ON
      -Dprotobuf_BUILD_SHARED_LIBS=ON
      -Dprotobuf_INSTALL_EXAMPLES=ON
      -Dprotobuf_BUILD_TESTS=#{OS.mac? ? "ON" : "OFF"}
      -Dprotobuf_USE_EXTERNAL_GTEST=ON
      -Dprotobuf_ABSL_PROVIDER=package
      -Dprotobuf_JSONCPP_PROVIDER=package
    ]

    system "cmake", "-S", ".", "-B", "build", *cmake_args, *std_cmake_args
    system "cmake", "--build", "build"
    system "ctest", "--test-dir", "build", "--verbose" if OS.mac?
    system "cmake", "--install", "build"

    (share/"vim/vimfiles/syntax").install "editors/proto.vim"
    elisp.install "editors/protobuf-mode.el"
  end

  test do
    (testpath/"test.proto").write <<~PROTO
      syntax = "proto3";
      package test;
      message TestCase {
        string name = 4;
      }
      message Test {
        repeated TestCase case = 1;
      }
    PROTO
    system bin/"protoc", "test.proto", "--cpp_out=."
  end
end
