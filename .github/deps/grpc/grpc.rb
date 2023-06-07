class Grpc < Formula
  desc "Next generation open source RPC library and framework"
  homepage "https://grpc.io/"
  url "https://github.com/grpc/grpc.git",
      tag:      "v1.55.1",
      revision: "12161ee3aa7c216741cd7c406573abc0df1d0926"
  license "Apache-2.0"
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
    sha256 cellar: :any,                 arm64_ventura:  "50baa508cecf4cf3d6b53c5c79c19556efdc27cfb6237e0143a0b04b7f6d6212"
    sha256 cellar: :any,                 arm64_monterey: "15369458871a962658c7c5bafe808b2e1c14d31d71c37db92b270707a83c0d38"
    sha256 cellar: :any,                 arm64_big_sur:  "b26fce392b65f68cf57a4b51e9bf5cd591c42b7be055f62cc0984e2f0b7e84df"
    sha256 cellar: :any,                 ventura:        "f14a340b042b8fa86b313805931ceffc20ef9077fba563fcd096e4b0490e79d8"
    sha256 cellar: :any,                 monterey:       "90f49af0fe0644fcc2fcb882e909d20dfe83757ec9e996b776c660f209f39ec1"
    sha256 cellar: :any,                 big_sur:        "b9894f0f7ef5c0905cb2b0f15ca50757d1007306d535725a1dcac30f4bfadb2b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f74ca2fb0723573b8d8e42fc089a63ad74e96456f491a6a914e277f49ab7c15c"
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
