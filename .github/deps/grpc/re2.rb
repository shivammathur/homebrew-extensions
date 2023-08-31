class Re2 < Formula
  desc "Alternative to backtracking PCRE-style regular expression engines"
  homepage "https://github.com/google/re2"
  url "https://github.com/google/re2/releases/download/2023-08-01/re2-2023-08-01.tar.gz"
  version "20230801"
  sha256 "d82d0efe2389949244445e7a6ac9a10fccc3d6a3d267ec4652991a51291647b0"
  license "BSD-3-Clause"
  revision 1
  head "https://github.com/google/re2.git", branch: "main"

  # The `strategy` block below is used to massage upstream tags into the
  # YYYYMMDD format used in the `version`. This is necessary for livecheck
  # to be able to do proper `Version` comparison.
  livecheck do
    url :stable
    regex(/^(\d{2,4}-\d{2}-\d{2})$/i)
    strategy :git do |tags, regex|
      tags.map { |tag| tag[regex, 1]&.gsub(/\D/, "") }.compact
    end
  end

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "a2b70824ac4b26a3f6f9852e9fd12859e79019ee6447635f883e65a9f47ea527"
    sha256 cellar: :any,                 arm64_monterey: "246784687e698eefdd42731c4b8c0133e870338622226d1ba362f02ba4559977"
    sha256 cellar: :any,                 arm64_big_sur:  "0b1582ae020b510e3f8572a24f7f923611d505fcc385259c44e7eabc77ba67a7"
    sha256 cellar: :any,                 ventura:        "9d96f22f2527831b314cf6e4f33e97362576cd4b3d8e84627b3112ae27870b0d"
    sha256 cellar: :any,                 monterey:       "defce8feb3fdacddcca25707de2a54631702eea9a5e7144c80129a5810e8aaec"
    sha256 cellar: :any,                 big_sur:        "4b677516914f09c0a068b5564ff43aa336ee065e511c1b2601e68a3625678635"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b8c3c88a193f9cc30fbe538d6e1e47a28c99f9e4aaef88e5c5f6be8fd7605894"
  end

  depends_on "cmake" => :build
  depends_on "abseil"

  def install
    # Build and install static library
    system "cmake", "-S", ".", "-B", "build-static",
                    "-DRE2_BUILD_TESTING=OFF",
                    *std_cmake_args
    system "cmake", "--build", "build-static"
    system "cmake", "--install", "build-static"

    # Build and install shared library
    system "cmake", "-S", ".", "-B", "build-shared",
                    "-DBUILD_SHARED_LIBS=ON",
                    "-DRE2_BUILD_TESTING=OFF",
                    *std_cmake_args
    system "cmake", "--build", "build-shared"
    system "cmake", "--install", "build-shared"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <re2/re2.h>
      #include <assert.h>
      int main() {
        assert(!RE2::FullMatch("hello", "e"));
        assert(RE2::PartialMatch("hello", "e"));
        return 0;
      }
    EOS
    system ENV.cxx, "-std=c++17", "test.cpp", "-o", "test",
                    "-I#{include}", "-L#{lib}", "-lre2"
    system "./test"
  end
end
