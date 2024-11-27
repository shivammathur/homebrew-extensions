class Librdkafka < Formula
  desc "Apache Kafka C/C++ library"
  homepage "https://github.com/confluentinc/librdkafka"
  url "https://github.com/confluentinc/librdkafka/archive/refs/tags/v2.6.1.tar.gz"
  sha256 "0ddf205ad8d36af0bc72a2fec20639ea02e1d583e353163bf7f4683d949e901b"
  license "BSD-2-Clause"
  head "https://github.com/confluentinc/librdkafka.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "c8cb62d6249166d482dbc61eabc6abe6a57effa571b5a4a03d9b2e2ee9b75d62"
    sha256 cellar: :any,                 arm64_sonoma:  "5a057cedacf435fb436f56e8fb18e85fdfb5a89a87465a7a0deeb3fe7eb8d648"
    sha256 cellar: :any,                 arm64_ventura: "aa31edae9841cf293319ebacf345b299e76767abee5d3e890ba704bdac755210"
    sha256 cellar: :any,                 sonoma:        "ca4719ab13622e709823e8a0c1582e087feacb1825dc2a4d3051c6725d2996bd"
    sha256 cellar: :any,                 ventura:       "8294e9370476400ea3ae4cd6ce95bc49c106372bae929008fc5f75e706c653a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1fea707e4636ced72b92ee2a83d4dc345ba66c7cada66533a575a5ec4e89cc37"
  end

  depends_on "pkgconf" => :build
  depends_on "lz4"
  depends_on "lzlib"
  depends_on "openssl@3"
  depends_on "zstd"

  uses_from_macos "python" => :build
  uses_from_macos "curl"
  uses_from_macos "cyrus-sasl"
  uses_from_macos "zlib"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <librdkafka/rdkafka.h>

      int main (int argc, char **argv)
      {
        int partition = RD_KAFKA_PARTITION_UA; /* random */
        int version = rd_kafka_version();
        return 0;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-lrdkafka", "-lz", "-lpthread", "-o", "test"
    system "./test"
  end
end
