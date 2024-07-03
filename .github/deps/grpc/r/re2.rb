class Re2 < Formula
  desc "Alternative to backtracking PCRE-style regular expression engines"
  homepage "https://github.com/google/re2"
  url "https://github.com/google/re2/archive/refs/tags/2024-07-02.tar.gz"
  version "20240702"
  sha256 "eb2df807c781601c14a260a507a5bb4509be1ee626024cb45acbd57cb9d4032b"
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
    sha256 cellar: :any,                 arm64_sonoma:   "824843d9a0e1ad155a4e1dabe6b71546422a644cdcbc2c135d8353ce93ccf8fb"
    sha256 cellar: :any,                 arm64_ventura:  "d3956ff7c3c6c8b7c4894d68ad33e344f05e07cee06029b53fc5810c8a66fd2e"
    sha256 cellar: :any,                 arm64_monterey: "887c5ea7a3f2b1649ed8f2d8ed5760763175c5638ac80e4e229d5508b38b91d8"
    sha256 cellar: :any,                 sonoma:         "6cc7864e53c5c6b3d9aaa63782939b5ab5ab7bbe37a35624869f8124a0051a59"
    sha256 cellar: :any,                 ventura:        "64f4aef693771a78177d80d42a188c9271c6c86fb832e01b2fe30ba1b9bd4a42"
    sha256 cellar: :any,                 monterey:       "20d3766116d5cc14276f0e3a24448e8c6f94efcada0faafbd2b4fea877997ef4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c73a463b68031fdd2974e54be429573656b83d9fe66a770be340c2e43d3ce798"
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
