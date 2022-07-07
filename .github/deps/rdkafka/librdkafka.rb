class Librdkafka < Formula
  desc "Apache Kafka C/C++ library"
  homepage "https://github.com/edenhill/librdkafka"
  url "https://github.com/edenhill/librdkafka/archive/refs/tags/v1.9.1.tar.gz"
  sha256 "3a54cf375218977b7af4716ed9738378e37fe400a6c5ddb9d622354ca31fdc79"
  license "BSD-2-Clause"
  head "https://github.com/edenhill/librdkafka.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_monterey: "0bf9a0fcb366e69b06bb98fcba8e220bd09ba47d2c45b3097488b6e2228eaef7"
    sha256 cellar: :any,                 arm64_big_sur:  "1a78e97248c3ed1a91617654971190b2f5765a9eaf106e7ce7a571cffa80b7d5"
    sha256                               monterey:       "7d17d195ba71d77be14ac6307eb45f40e1a592411bf148fd206d4e991e1224ff"
    sha256                               big_sur:        "c6facc3398c7a18b456fd8dffb9fa3535c1e7175ecb4af13005362d285555a7f"
    sha256                               catalina:       "f4d5ea655375f120a69a0ebaf97c0c67484cf89b3c72783028c0c6b7edb9c0b7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7aef625f105238db7cf50baa1ca0729607c37bb89cc916ec713846dfc36a4260"
  end

  depends_on "pkg-config" => :build
  depends_on "python@3.10" => :build
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
