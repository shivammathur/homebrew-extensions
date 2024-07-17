class CAres < Formula
  desc "Asynchronous DNS library"
  homepage "https://c-ares.org/"
  url "https://github.com/c-ares/c-ares/releases/download/v1.32.2/c-ares-1.32.2.tar.gz"
  sha256 "072ff6b30b9682d965b87eb9b77851dc1cd8e6d8090f6821a56bd8fa89595061"
  license "MIT"
  head "https://github.com/c-ares/c-ares.git", branch: "main"

  livecheck do
    url :homepage
    regex(/href=.*?c-ares[._-](\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "d6b0eed0b6a0328c8619783106ae022d85413b03a3af32fea23aae7111c0d84a"
    sha256 cellar: :any,                 arm64_ventura:  "9c006bd90eee4a3a413dc98a81097e880cb0327c2c8130938df436d4ef0087e7"
    sha256 cellar: :any,                 arm64_monterey: "6a3f0f08e69e6dd0821780d0d95f607dabba293e8f0a5a231edb8644801b5bb2"
    sha256 cellar: :any,                 sonoma:         "c166401d944c8859feef77bd87373f743dd9999f9eb66e38523a70cb0afecb3c"
    sha256 cellar: :any,                 ventura:        "e1a338804739f4b157c59eeec1bb3906785dbe2d4e793a0a2ef04b5869e60f60"
    sha256 cellar: :any,                 monterey:       "07f738edacc773868bb35bc280e450871d0ad939a09ad3ea9e3d8a4d7df534e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ec264c2ede66cd30bc90008b99059ff75404f4c598c210386d373baa14dc4d05"
  end

  depends_on "cmake" => :build

  def install
    args = %W[
      -DCARES_STATIC=ON
      -DCARES_SHARED=ON
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include <ares.h>

      int main()
      {
        ares_library_init(ARES_LIB_INIT_ALL);
        ares_library_cleanup();
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lcares", "-o", "test"
    system "./test"

    system bin/"ahost", "127.0.0.1"
  end
end
