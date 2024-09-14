class Protobuf < Formula
  desc "Protocol buffers (Google's data interchange format)"
  homepage "https://protobuf.dev/"
  url "https://github.com/protocolbuffers/protobuf/releases/download/v28.1/protobuf-28.1.tar.gz"
  sha256 "3b8bf6e96499a744bd014c60b58f797715a758093abf859f1d902194b8e1f8c9"
  license "BSD-3-Clause"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "b81d8671946f9a70a34b8e7894f272ac5a6dcf56b15de92fb667e83f360da9bb"
    sha256 cellar: :any,                 arm64_sonoma:  "c399dcd8e8246c286b1e744cc7dabe499493eeea67af3720328871da497af5a3"
    sha256 cellar: :any,                 arm64_ventura: "5f5f007500d7adc474a0f515fb07291506e1cf0bd92c538ee75382cf18bd6725"
    sha256 cellar: :any,                 sonoma:        "85f2c7d3d03b09386bf29ce9484bafdbeaa9f4f21992c5672159e0720abd6310"
    sha256 cellar: :any,                 ventura:       "738a87bd1330bc27393cf5e7ebab0b9b01a08bb3009b990791237bd8721751b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e0ef7a5f3b7cd2a18781e5f4a358d6ae5549b150b9baf09b74c5d8f6a95a5a69"
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
