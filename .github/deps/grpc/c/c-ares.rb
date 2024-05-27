class CAres < Formula
  desc "Asynchronous DNS library"
  homepage "https://c-ares.org/"
  license "MIT"
  head "https://github.com/c-ares/c-ares.git", branch: "main"

  # Remove `stable` block when `dnsinfo.h` resource is no longer needed.
  stable do
    # Don't forget to change both instances of the version in the first mirror. (e.g. `cares-1_xy_z`)
    url "https://c-ares.org/download/c-ares-1.29.0.tar.gz"
    mirror "https://github.com/c-ares/c-ares/releases/download/cares-1_29_0/c-ares-1.29.0.tar.gz"
    mirror "http://fresh-center.net/linux/misc/dns/c-ares-1.29.0.tar.gz"
    mirror "http://fresh-center.net/linux/misc/dns/legacy/c-ares-1.29.0.tar.gz"
    sha256 "0b89fa425b825c4c7bc708494f374ae69340e4d1fdc64523bdbb2750bfc02ea7"

    # TODO: Remove at next release.
    resource "dnsinfo.h" do
      url "https://raw.githubusercontent.com/c-ares/c-ares/6bbdcf766eeab31b3c8f3e471fb6beceb18ff351/src/lib/thirdparty/apple/dnsinfo.h"
      sha256 "9b8b3c820a6708f0add91887e8332e2700f7dfab6d9c2cf74866d4c2f26d58ea"
    end
  end

  livecheck do
    url :homepage
    regex(/href=.*?c-ares[._-](\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "50b8ff29e104224eb64084cea5119fba638e1455d4300d28febc731c83d6e540"
    sha256 cellar: :any,                 arm64_ventura:  "02ceb19766f82e841a09f9ab43877b5a1cda9297f22e301625a7388b42c85be8"
    sha256 cellar: :any,                 arm64_monterey: "809e8f0274735468d9cb268b9cf14bc1614212556571f86d8e8e65c6ced022a0"
    sha256 cellar: :any,                 sonoma:         "c4b105e475ab425140af36ad950a6c6cabe472a16889023728f6c42bc5f22f0b"
    sha256 cellar: :any,                 ventura:        "e36d47a8a81e36b4c6da725e909b91743dd52e57103891506de44f9764370c65"
    sha256 cellar: :any,                 monterey:       "698e01cd2e616a944147ce7a1f9173efb0e1e869350589527dcedee06ba9bc29"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "77488d72926f8ea72ae6a5383f01389b9f25d7fac1297be30fc96cd20f81e6bb"
  end

  depends_on "cmake" => :build

  def install
    if build.stable?
      (buildpath/"src/lib/thirdparty/apple").install resource("dnsinfo.h")
      odie "The `dnsinfo.h` resource should be removed!" if version > "1.29.0"
    end

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

    system "#{bin}/ahost", "127.0.0.1"
  end
end
