class Libnghttp2 < Formula
  desc "HTTP/2 C Library"
  homepage "https://nghttp2.org/"
  url "https://github.com/nghttp2/nghttp2/releases/download/v1.58.0/nghttp2-1.58.0.tar.gz"
  mirror "http://fresh-center.net/linux/www/nghttp2-1.58.0.tar.gz"
  mirror "http://fresh-center.net/linux/www/legacy/nghttp2-1.58.0.tar.gz"
  # this legacy mirror is for user to install from the source when https not working for them
  # see discussions in here, https://github.com/Homebrew/homebrew-core/pull/133078#discussion_r1221941917
  sha256 "9ebdfbfbca164ef72bdf5fd2a94a4e6dfb54ec39d2ef249aeb750a91ae361dfb"
  license "MIT"

  livecheck do
    formula "nghttp2"
  end

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "0aea68bfb61161efd6c7f36fa64e48406a716e93dcb2bc362ac443fd802914a6"
    sha256 cellar: :any,                 arm64_ventura:  "73d3d70d47edc13dc862954d248fad4df7ca33e239dbe3ef09d3f16551bfe6bd"
    sha256 cellar: :any,                 arm64_monterey: "3b689c48ebac8bae3b73849137d30804d8ed852a80152d3a7e879fe05c428f8c"
    sha256 cellar: :any,                 sonoma:         "14a08800cac734d4b2722864ba2b03ae786aa5dfee3d224ee71b2c8bd88b16c4"
    sha256 cellar: :any,                 ventura:        "aade94da572c92514434f1afe7617da53a0f777fcd06dece3f4ec59f26b5b0fe"
    sha256 cellar: :any,                 monterey:       "720bec651f4930bbce2da6bcb2b869e8faa4ec8a8bba717207e0c8ce63c562cd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1723ddcaacc3ad10052a0cb4e8cc1644f1ddfd6b51a70a3f9a57c98b247134a4"
  end

  head do
    url "https://github.com/nghttp2/nghttp2.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build

  # These used to live in `nghttp2`.
  link_overwrite "include/nghttp2"
  link_overwrite "lib/libnghttp2.a"
  link_overwrite "lib/libnghttp2.dylib"
  link_overwrite "lib/libnghttp2.14.dylib"
  link_overwrite "lib/libnghttp2.so"
  link_overwrite "lib/libnghttp2.so.14"
  link_overwrite "lib/pkgconfig/libnghttp2.pc"

  def install
    system "autoreconf", "-ivf" if build.head?
    system "./configure", *std_configure_args, "--enable-lib-only"
    system "make", "-C", "lib"
    system "make", "-C", "lib", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <nghttp2/nghttp2.h>
      #include <stdio.h>

      int main() {
        nghttp2_info *info = nghttp2_version(0);
        printf("%s", info->version_str);
        return 0;
      }
    EOS

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lnghttp2", "-o", "test"
    assert_equal version.to_s, shell_output("./test")
  end
end
