class Protobuf < Formula
  desc "Protocol buffers (Google's data interchange format)"
  homepage "https://protobuf.dev/"
  url "https://github.com/protocolbuffers/protobuf/releases/download/v24.2/protobuf-24.2.tar.gz"
  sha256 "39b52572da90ad54c883a828cb2ca68e5ac918aa75d36c3e55c9c76b94f0a4f7"
  license "BSD-3-Clause"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256                               arm64_ventura:  "3b173a2ed3ebe8cd383bab3bf5ef147a90d24ffb1a78b0bd13843a263dd6a4ed"
    sha256                               arm64_monterey: "dfda9d3ae29b2694866da200b5b5f57f69c40695188ac97d5dba21add708d4ca"
    sha256                               arm64_big_sur:  "996d34da22950cb630758fe5238c3fa0106e481acae5eb54be60465686b076f7"
    sha256                               ventura:        "cbd7162c35033994ecc6f3350e7f5afed460266cde554d6f6d856d95d6757124"
    sha256                               monterey:       "28d745d48da045aa7172305d74027cd5b13a5e800489e235448f14294956bebb"
    sha256                               big_sur:        "e4530950bd69986ef25bb3c50c24e61217af6f8700055655c316816aa32877db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "891749251502eea800f0960e66a28345591929e0f5be09ccbb3570fa2fe31aa4"
  end

  depends_on "cmake" => :build
  depends_on "python@3.10" => [:build, :test]
  depends_on "python@3.11" => [:build, :test]
  depends_on "abseil"
  depends_on "jsoncpp"

  uses_from_macos "zlib"

  def pythons
    deps.map(&:to_formula)
        .select { |f| f.name.match?(/^python@\d\.\d+$/) }
        .map { |f| f.opt_libexec/"bin/python" }
  end

  def install
    # Keep `CMAKE_CXX_STANDARD` in sync with the same variable in `abseil.rb`.
    abseil_cxx_standard = 17
    cmake_args = %w[
      -DBUILD_SHARED_LIBS=ON
      -Dprotobuf_BUILD_LIBPROTOC=ON
      -Dprotobuf_BUILD_SHARED_LIBS=ON
      -Dprotobuf_INSTALL_EXAMPLES=ON
      -Dprotobuf_BUILD_TESTS=OFF
      -Dprotobuf_ABSL_PROVIDER=package
      -Dprotobuf_JSONCPP_PROVIDER=package
    ]
    cmake_args << "-DCMAKE_CXX_STANDARD=#{abseil_cxx_standard}"

    system "cmake", "-S", ".", "-B", "build", *cmake_args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    (share/"vim/vimfiles/syntax").install "editors/proto.vim"
    elisp.install "editors/protobuf-mode.el"

    ENV.append_to_cflags "-I#{include}"
    ENV.append_to_cflags "-L#{lib}"
    ENV["PROTOC"] = bin/"protoc"

    cd "python" do
      # Keep C++ standard in sync with `abseil.rb`.
      inreplace "setup.py", "extra_compile_args.append('-std=c++14')",
                            "extra_compile_args.append('-std=c++#{abseil_cxx_standard}')"
      pythons.each do |python|
        pyext_dir = prefix/Language::Python.site_packages(python)/"google/protobuf/pyext"
        with_env(LDFLAGS: "-Wl,-rpath,#{rpath(source: pyext_dir)} #{ENV.ldflags}".strip) do
          system python, *Language::Python.setup_install_args(prefix, python), "--cpp_implementation"
        end
      end
    end
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

    pythons.each do |python|
      system python, "-c", "from google.protobuf.pyext import _message"
    end
  end
end
