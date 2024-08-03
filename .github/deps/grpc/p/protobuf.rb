class Protobuf < Formula
  desc "Protocol buffers (Google's data interchange format)"
  homepage "https://protobuf.dev/"
  url "https://github.com/protocolbuffers/protobuf/releases/download/v27.3/protobuf-27.3.tar.gz"
  sha256 "1535151efbc7893f38b0578e83cac584f2819974f065698976989ec71c1af84a"
  license "BSD-3-Clause"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "ef49251d7dcbf1ed41c1cfbf861f8b79ab5798c27658f76b836ac4d5be21a6da"
    sha256 cellar: :any,                 arm64_ventura:  "acf2248d085678edee5e7e89c214b30e36e620e66a38dc29b881ce9288e8e412"
    sha256 cellar: :any,                 arm64_monterey: "e088b3cbcbd625b9abc24794e4df00e7142d0b7edb476fe120f35e3aef667ff6"
    sha256 cellar: :any,                 sonoma:         "4ea12f80efc823c067d1ffeb76ca2e86fd9cfd03866f3ecdc4bbb86876feb5ce"
    sha256 cellar: :any,                 ventura:        "e32ccce57d7121052a34257b470a117fad7a26a82f30cea841081dbab5a8bb2e"
    sha256 cellar: :any,                 monterey:       "6bdad04930839eaddccba5e4efa229f49bffd27e5205fa642cf0eb601bd534d7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "040275d703222fac0c09f8f9e49e27387220c3e7e831f8e362536f0365b97562"
  end

  depends_on "cmake" => :build
  depends_on "abseil"
  uses_from_macos "zlib"

  on_macos do
    # We currently only run tests on macOS.
    # Running them on Linux requires rebuilding googletest with `-fPIC`.
    depends_on "googletest" => :build
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
