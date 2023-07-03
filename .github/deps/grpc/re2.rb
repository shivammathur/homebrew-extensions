class Re2 < Formula
  desc "Alternative to backtracking PCRE-style regular expression engines"
  homepage "https://github.com/google/re2"
  url "https://github.com/google/re2/archive/refs/tags/2023-06-01.tar.gz"
  version "20230601"
  sha256 "8b4a8175da7205df2ad02e405a950a02eaa3e3e0840947cd598e92dca453199b"
  license "BSD-3-Clause"
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
    sha256 cellar: :any,                 arm64_ventura:  "ddd3e26da47e8f60e0d98cd1ec37077281d22b14dda7ee3e5eb0acd5bd3382cb"
    sha256 cellar: :any,                 arm64_monterey: "f780af4e541d3dc7c93d5189877e9fe5c12b361a47f74ee1f8d223bbfdf80d1c"
    sha256 cellar: :any,                 arm64_big_sur:  "f81bf7d09fecf1eb1d5465335abd5cb0f357e6fed4202cf3e75281b07bdd15c0"
    sha256 cellar: :any,                 ventura:        "b366f7acbed16dd1b76000eb131c5c87307a7005e155f8c235ea6d72cf43fb96"
    sha256 cellar: :any,                 monterey:       "c491ec9b6d6d35f74474c14ce21309e96ad3766433a858c68bd40b732515f694"
    sha256 cellar: :any,                 big_sur:        "43c2bf97c8209d5fb7ed8b44b78e7c85ff0cfd83e933552cf679474e1a086843"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d14fd85a5c45fe2fddb92913beb489a2644e2bf91fd2a543f525d8d239703ebc"
  end

  depends_on "cmake" => :build
  depends_on "abseil"

  def install
    # Build and install static library
    system "cmake", "-B", "build-static", "-DRE2_BUILD_TESTING=OFF", *std_cmake_args
    system "make", "-C", "build-static"
    system "make", "-C", "build-static",  "install"

    # Build and install shared library
    system "cmake", "-B", "build-shared", "-DBUILD_SHARED_LIBS=ON", "-DRE2_BUILD_TESTING=OFF", *std_cmake_args
    system "make", "-C", "build-shared"
    system "make", "-C", "build-shared", "install"
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
