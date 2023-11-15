class CAres < Formula
  desc "Asynchronous DNS library"
  homepage "https://c-ares.org/"
  url "https://c-ares.org/download/c-ares-1.22.0.tar.gz"
  mirror "https://github.com/c-ares/c-ares/releases/download/cares-1_17_2/c-ares-1.22.0.tar.gz"
  mirror "http://fresh-center.net/linux/misc/dns/c-ares-1.22.0.tar.gz"
  mirror "http://fresh-center.net/linux/misc/dns/legacy/c-ares-1.22.0.tar.gz"
  sha256 "ad2e205088083317147c9f9eab5f24b82c3d50927c381a7c963deeb1182dbc21"
  license "MIT"
  head "https://github.com/c-ares/c-ares.git", branch: "main"

  livecheck do
    url :homepage
    regex(/href=.*?c-ares[._-](\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "88d6c76039fb931c3f51a4549703eee81db44f9811bbdec0cc5a48d1a3b3248c"
    sha256 cellar: :any,                 arm64_ventura:  "b2fdf01314225d8264fd27ead4365ec49e22e21b878a6a6a8cc3789b83e81f93"
    sha256 cellar: :any,                 arm64_monterey: "2778ed1c9591052e0c5c86170c11549bfb6026fbee885285428825e358a251ad"
    sha256 cellar: :any,                 sonoma:         "54de1e52199b9727c45f64b2c45dbdfaed205ae4c1ce02fd95b27ff7e9027363"
    sha256 cellar: :any,                 ventura:        "2e0b7c32cd619918f735347e1535ea0757c1b6a7a8033395036e856022344e70"
    sha256 cellar: :any,                 monterey:       "17ee2c4bf0cff496fab5ff83499fc1dc8124b36a50f03f28a64a852c67bc717d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5012bd2e2b57f58091b05991ce8b3dc63e25057976d6c7b6cb03a4dc2cf269cb"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DCMAKE_INSTALL_RPATH=#{rpath}"
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

    system "#{bin}/ahost", "127.0.0.1"
  end
end
