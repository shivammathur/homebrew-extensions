class CAres < Formula
  desc "Asynchronous DNS library"
  homepage "https://c-ares.org/"
  url "https://github.com/c-ares/c-ares/releases/download/v1.31.0/c-ares-1.31.0.tar.gz"
  sha256 "0167a33dba96ca8de29f3f598b1e6cabe531799269fd63d0153aa0e6f5efeabd"
  license "MIT"
  head "https://github.com/c-ares/c-ares.git", branch: "main"

  livecheck do
    url :homepage
    regex(/href=.*?c-ares[._-](\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "11180fb00208951f6c8b3dec74aa45b3eca218aeb1eaf17d815b5b278e87b375"
    sha256 cellar: :any,                 arm64_ventura:  "cb9eff64af832838a2602e5ac61a7c88577ff54a6388f29249b0a29098d1ce7a"
    sha256 cellar: :any,                 arm64_monterey: "ed91ecf0fd5ca9f34bc22eb3e887340dbf9da9d7727aa4f0619e65bfed515a0e"
    sha256 cellar: :any,                 sonoma:         "b023ac11fc4e1d06dceb10025399b8579d1b9169b9ca9a8380c7da0981b1d99c"
    sha256 cellar: :any,                 ventura:        "bd75383890a841367ffbbedee20b2e597052dd67f858624ea7ac7d09ac18fb63"
    sha256 cellar: :any,                 monterey:       "4d46dfc87289364928398ca768505f4f9cb82e5218bd53ba019eacb97c8db614"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e34f7b56d0ebe1796f064c5d026f70be92d2069f12ac60c585b12f822e2b8f2d"
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
