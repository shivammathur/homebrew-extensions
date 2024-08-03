class Grpc < Formula
  desc "Next generation open source RPC library and framework"
  homepage "https://grpc.io/"
  license "Apache-2.0"
  revision 3
  head "https://github.com/grpc/grpc.git", branch: "master"

  stable do
    url "https://github.com/grpc/grpc.git",
        tag:      "v1.62.2",
        revision: "96f984744fe728e196c11d33b91b022566c0d40f"

    # Backport fix for Protobuf 26
    patch do
      url "https://github.com/grpc/grpc/commit/98a96c5068da14ed29d70ca23818b5f408a2e7b4.patch?full_index=1"
      sha256 "5c4fc4307d0943ce3c9a07921bddaa24ca3d504adf38c9b0f071e23327661ac1"
    end
  end

  # There can be a notable gap between when a version is tagged and a
  # corresponding release is created, so we check releases instead of the Git
  # tags. Upstream maintains multiple major/minor versions and the "latest"
  # release may be for an older version, so we have to check multiple releases
  # to identify the highest version.
  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "10b6cf851d6af89a2daa5aeb78c1b6df1b84bc17de063bc67c6c8692d47a131e"
    sha256 cellar: :any,                 arm64_ventura:  "d60f5bcc6a3d751f5b5b5d3a2ce9604cc299a59746e63ff061fcf8dbfca5071d"
    sha256 cellar: :any,                 arm64_monterey: "1c613c138211c8d59291a74c6cab6fb5ec0e4ef66652c4e97433ec93fa1ec83a"
    sha256 cellar: :any,                 sonoma:         "21e448553644f5f6abe9a467a241e645f829a3a8da59060fc0f3a88e9e1f2208"
    sha256 cellar: :any,                 ventura:        "04143aadea21d8d7a899afb0f87481b8d5eb00c12c9823d2f3bc751fdad8f88f"
    sha256 cellar: :any,                 monterey:       "cc9f94c1992e5800acffde0b801a2152953e523a7d0e5a713a3c4affd1b48f59"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5bfccecf4ecf965d34d8e20f2c130188a6778ab13958a16fb6398a95ad55559e"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "cmake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :test
  depends_on "abseil"
  depends_on "c-ares"
  depends_on "openssl@3"
  depends_on "protobuf"
  depends_on "re2"

  uses_from_macos "zlib"

  on_macos do
    depends_on "llvm" => :build if DevelopmentTools.clang_build_version <= 1100
  end

  fails_with :clang do
    build 1100
    cause "Requires C++17 features not yet implemented"
  end

  fails_with gcc: "5" # C++17

  def install
    ENV.llvm_clang if OS.mac? && (DevelopmentTools.clang_build_version <= 1100)
    args = %W[
      -DCMAKE_CXX_STANDARD=17
      -DCMAKE_CXX_STANDARD_REQUIRED=TRUE
      -DCMAKE_INSTALL_RPATH=#{rpath}
      -DBUILD_SHARED_LIBS=ON
      -DgRPC_BUILD_TESTS=OFF
      -DgRPC_INSTALL=ON
      -DgRPC_ABSL_PROVIDER=package
      -DgRPC_CARES_PROVIDER=package
      -DgRPC_PROTOBUF_PROVIDER=package
      -DgRPC_SSL_PROVIDER=package
      -DgRPC_ZLIB_PROVIDER=package
      -DgRPC_RE2_PROVIDER=package
    ]
    system "cmake", "-S", ".", "-B", "_build", *args, *std_cmake_args
    system "cmake", "--build", "_build"
    system "cmake", "--install", "_build"

    # The following are installed manually, so need to use CMAKE_*_LINKER_FLAGS
    args = %W[
      -DCMAKE_EXE_LINKER_FLAGS=-Wl,-rpath,#{rpath}
      -DCMAKE_SHARED_LINKER_FLAGS=-Wl,-rpath,#{rpath}
      -DBUILD_SHARED_LIBS=ON
      -DgRPC_BUILD_TESTS=ON
    ]
    system "cmake", "-S", ".", "-B", "_build", *args, *std_cmake_args
    system "cmake", "--build", "_build", "--target", "grpc_cli"
    bin.install "_build/grpc_cli"
    lib.install Dir["_build/#{shared_library("libgrpc++_test_config", "*")}"]
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <grpc/grpc.h>
      int main() {
        grpc_init();
        grpc_shutdown();
        return GRPC_STATUS_OK;
      }
    EOS
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["openssl@3"].opt_lib/"pkgconfig"
    pkg_config_flags = shell_output("pkg-config --cflags --libs libcares protobuf re2 grpc++").chomp.split
    system ENV.cc, "test.cpp", "-L#{Formula["abseil"].opt_lib}", *pkg_config_flags, "-o", "test"
    system "./test"

    output = shell_output("#{bin}/grpc_cli ls localhost:#{free_port} 2>&1", 1)
    assert_match "Received an error when querying services endpoint.", output
  end
end
