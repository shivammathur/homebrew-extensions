class Librdkafka < Formula
  desc "Apache Kafka C/C++ library"
  homepage "https://github.com/edenhill/librdkafka"
  url "https://github.com/edenhill/librdkafka/archive/refs/tags/v1.9.2.tar.gz"
  sha256 "3fba157a9f80a0889c982acdd44608be8a46142270a389008b22d921be1198ad"
  license "BSD-2-Clause"
  head "https://github.com/edenhill/librdkafka.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_ventura:  "aaf5be4abca614fec8e7b1ce7de8cd1ca2bc3289a5987b35e76bc4492572e817"
    sha256 cellar: :any,                 arm64_monterey: "3ad6b84bb1812a86b79037ef3712cac8c655378d391baf34f7e7c7a78ce35bca"
    sha256 cellar: :any,                 arm64_big_sur:  "5b9081eb9326f365f263869ac727aa1c54f93a6e81a4a6bf6ea5f45d56e5bfd3"
    sha256                               ventura:        "853179bfed485e17203f48bce282df6e9e4cbb8c28a6682cb2891d05d9e83851"
    sha256                               monterey:       "6fdf31963089900e263a2ecf9b9d9d4311663cd70e3f333d925262c6b41c976c"
    sha256                               big_sur:        "e56ea38be19a683be72690eead6e4394f00ca008de64f34008fe477d2539dd6b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "146e7981060c0a030695cea369cfbc587c139f1dc024ebc01d4872883837241e"
  end

  depends_on "pkg-config" => :build
  depends_on "python@3.11" => :build
  depends_on "lz4"
  depends_on "lzlib"
  depends_on "openssl@1.1"
  depends_on "zstd"

  uses_from_macos "curl"
  uses_from_macos "cyrus-sasl"
  uses_from_macos "zlib"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <librdkafka/rdkafka.h>

      int main (int argc, char **argv)
      {
        int partition = RD_KAFKA_PARTITION_UA; /* random */
        int version = rd_kafka_version();
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lrdkafka", "-lz", "-lpthread", "-o", "test"
    system "./test"
  end
end
