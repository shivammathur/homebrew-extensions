class Grpc < Formula
  desc "Next generation open source RPC library and framework"
  homepage "https://grpc.io/"
  url "https://github.com/grpc/grpc.git",
      tag:      "v1.56.0",
      revision: "6e85620c7e258df79666a4743f862f2f82701c2d"
  license "Apache-2.0"
  revision 1
  head "https://github.com/grpc/grpc.git", branch: "master"

  # The "latest" release on GitHub is sometimes for an older major/minor and
  # there's sometimes a notable gap between when a version is tagged and
  # released, so we have to check the releases page instead.
  livecheck do
    url "https://github.com/grpc/grpc/releases?q=prerelease%3Afalse"
    regex(%r{href=["']?[^"' >]*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
    strategy :page_match
  end

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "95fc70af5d0c812ee732ee9e62b59aadad03d2199f24292ac68a5e21609a8496"
    sha256 cellar: :any,                 arm64_monterey: "04b4f5c73a9370b74c510b1776343a9bc3356c664f7296457d06edb5c14ffa4f"
    sha256 cellar: :any,                 arm64_big_sur:  "49250d95f0c4d698bf13fdaf76a3a9b20c56b73fe8457bc683a24dee17989b45"
    sha256 cellar: :any,                 ventura:        "f4d9d8c11b7b9985d4e45921cc8764596802b34719698a9f3de1686252a725f9"
    sha256 cellar: :any,                 monterey:       "12c2e7ddb07b4c24c848dd962b35afd03e8787619d271613e310cd965d137591"
    sha256 cellar: :any,                 big_sur:        "6722e2537b62ed09a43e094049290b9d2434b4e30e7ccb36f8cae2bc514453bb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0f514a4877bfd9c30f61aa14f2b5432db92f987d723b2d84d2aeb86583a367d2"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "cmake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :test
  depends_on "abseil"
  depends_on "c-ares"
  depends_on "openssl@1.1"
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

  # Fix `find_dependency` call in gRPCConfig.cmake
  # https://github.com/grpc/grpc/pull/33361
  patch do
    url "https://github.com/grpc/grpc/commit/117dc80eb43021dd5619023ef6d02d0d6ec7ae7a.patch?full_index=1"
    sha256 "826896efc97e6c3bd3c38fc5e09642db4c6c4ec54597624ee8905da89e1ba7b6"
  end

  def install
    ENV.llvm_clang if OS.mac? && (DevelopmentTools.clang_build_version <= 1100)
    mkdir "cmake/build" do
      args = %W[
        ../..
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
      ] + std_cmake_args

      system "cmake", *args
      system "make", "install"

      args = %W[
        ../..
        -DCMAKE_INSTALL_RPATH=#{rpath}
        -DBUILD_SHARED_LIBS=ON
        -DgRPC_BUILD_TESTS=ON
      ] + std_cmake_args
      system "cmake", *args
      system "make", "grpc_cli"
      bin.install "grpc_cli"
      lib.install Dir[shared_library("libgrpc++_test_config", "*")]

      if OS.mac?
        # These are installed manually, so need to be relocated manually as well
        MachO::Tools.add_rpath(bin/"grpc_cli", rpath)
        MachO::Tools.add_rpath(lib/shared_library("libgrpc++_test_config"), rpath)
      end
    end
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
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["openssl@1.1"].opt_lib/"pkgconfig"
    pkg_config_flags = shell_output("pkg-config --cflags --libs libcares protobuf re2 grpc++").chomp.split
    system ENV.cc, "test.cpp", "-L#{Formula["abseil"].opt_lib}", *pkg_config_flags, "-o", "test"
    system "./test"

    output = shell_output("#{bin}/grpc_cli ls localhost:#{free_port} 2>&1", 1)
    assert_match "Received an error when querying services endpoint.", output
  end
end
