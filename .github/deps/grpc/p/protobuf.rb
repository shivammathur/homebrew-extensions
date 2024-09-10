class Protobuf < Formula
  desc "Protocol buffers (Google's data interchange format)"
  homepage "https://protobuf.dev/"
  url "https://github.com/protocolbuffers/protobuf/releases/download/v28.0/protobuf-28.0.tar.gz"
  sha256 "13e7749c30bc24af6ee93e092422f9dc08491c7097efa69461f88eb5f61805ce"
  license "BSD-3-Clause"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia:  "57ec31713ee55103917c3d2cc8e7115f26effd9e27ade607cac2a95f80f0b566"
    sha256 cellar: :any,                 arm64_sonoma:   "6f12e8d115e55beaf9ea358f5762d30d66d7adda6499b194365e5c7da13f13e7"
    sha256 cellar: :any,                 arm64_ventura:  "2aadb9d0cb5bcad4e8cdedc27184a889f1a9333e8147ef94e80017accf3df518"
    sha256 cellar: :any,                 arm64_monterey: "1a1a0733dff2a245306baed187c4dcd514b8ad1a93235920aa732c3bffd7c673"
    sha256 cellar: :any,                 sonoma:         "783d1c4cba09796c5cd162e56e98d865cb6e9813254009d94dc7c06160b6beb6"
    sha256 cellar: :any,                 ventura:        "0cbce97b65491740e1f317f1e91eb0e0180d3ce69ea95769b193493845456e3c"
    sha256 cellar: :any,                 monterey:       "446a30d9ae535f0b080dbdf488903723f666c0a48621250d8de75543adf9ce33"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ab41442af1732d685b62b71096e3fb268efe0d4e3505295057494ea4f50bb47f"
  end

  depends_on "cmake" => :build
  depends_on "abseil"
  uses_from_macos "zlib"

  on_macos do
    # We currently only run tests on macOS.
    # Running them on Linux requires rebuilding googletest with `-fPIC`.
    depends_on "googletest" => :build
  end

  patch do
    url "https://github.com/protocolbuffers/protobuf/commit/e490bff517916495ed3a900aa85791be01f674f5.patch?full_index=1"
    sha256 "7e89d0c379d89b24cb6fe795cd9d68e72f0b83fcc95dd91af721d670ad466022"
  end

  def install
    # Keep `CMAKE_CXX_STANDARD` in sync with the same variable in `abseil.rb`.
    abseil_cxx_standard = 17
    cmake_args = %W[
      -DBUILD_SHARED_LIBS=ON
      -Dprotobuf_BUILD_LIBPROTOC=ON
      -Dprotobuf_BUILD_SHARED_LIBS=ON
      -Dprotobuf_INSTALL_EXAMPLES=ON
      -Dprotobuf_BUILD_TESTS=#{OS.mac? ? "ON" : "OFF"}
      -Dprotobuf_USE_EXTERNAL_GTEST=ON
      -Dprotobuf_ABSL_PROVIDER=package
      -Dprotobuf_JSONCPP_PROVIDER=package
    ]
    cmake_args << "-DCMAKE_CXX_STANDARD=#{abseil_cxx_standard}"

    system "cmake", "-S", ".", "-B", "build", *cmake_args, *std_cmake_args
    system "cmake", "--build", "build"
    system "ctest", "--test-dir", "build", "--verbose" if OS.mac?
    system "cmake", "--install", "build"

    (share/"vim/vimfiles/syntax").install "editors/proto.vim"
    elisp.install "editors/protobuf-mode.el"
  end

  test do
    testdata = <<~EOS
      syntax = "proto3";
      package test;
      message TestCase {
        string name = 4;
      }
      message Test {
        repeated TestCase case = 1;
      }
    EOS
    (testpath/"test.proto").write testdata
    system bin/"protoc", "test.proto", "--cpp_out=."
  end
end
