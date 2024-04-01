class Re2 < Formula
  desc "Alternative to backtracking PCRE-style regular expression engines"
  homepage "https://github.com/google/re2"
  url "https://github.com/google/re2/archive/refs/tags/2024-04-01.tar.gz"
  version "20240401"
  sha256 "3f6690c3393a613c3a0b566309cf04dc381d61470079b653afc47c67fb898198"
  license "BSD-3-Clause"
  head "https://github.com/google/re2.git", branch: "main"

  # The `strategy` block below is used to massage upstream tags into the
  # YYYYMMDD format used in the `version`. This is necessary for livecheck
  # to be able to do proper `Version` comparison.
  livecheck do
    url :stable
    regex(/^(\d{2,4}-\d{2}-\d{2})$/i)
    strategy :git do |tags, regex|
      tags.filter_map { |tag| tag[regex, 1]&.gsub(/\D/, "") }
    end
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "cbc85c66387bdab256f91084869d450032c084ea0cc8b67b46aa0e07c9941e38"
    sha256 cellar: :any,                 arm64_ventura:  "e38d3dbdc7b557ed069c7da3c9cad8425c0d61bc314e11d91b7a9b8a45126ea3"
    sha256 cellar: :any,                 arm64_monterey: "e7f07e0a82653dff480e16bb166206dd2b14a2fb97da5b8ce3ee0514da14dfa8"
    sha256 cellar: :any,                 sonoma:         "e4f4a8421b39f38331e628d8ac1f4b6e5d9945b5ef8acf17dad664fec99b56af"
    sha256 cellar: :any,                 ventura:        "a21f845f071a5e89eae1ef9417717a4dad4f08de0ce5836ef1c66cefed7e5469"
    sha256 cellar: :any,                 monterey:       "202bb2aad583774f9955295742a717d7a9afac616ca0679d24ee21a0d6242dd1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "958538d02fa533529f68797e2854c2799e765d0d5088ae879437cd30dd8bc5c1"
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
