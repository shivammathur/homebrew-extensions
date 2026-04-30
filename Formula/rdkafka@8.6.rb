# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT86 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.5.tgz"
  sha256 "0af6b665c963c8c7d1109cec738034378d9c8863cbf612c0bd3235e519a708f1"
  head "https://github.com/arnaud-lb/php-rdkafka.git", branch: "6.x"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/rdkafka/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_tahoe:   "884602900b2a3e01c753bb151118e2406eb872b590d2726807f255a4bac81d3e"
    sha256 cellar: :any,                 arm64_sequoia: "b436c7fa6572b5c492bca64af303cd5118320f50fd8946e027177f0c1f3d4378"
    sha256 cellar: :any,                 arm64_sonoma:  "52a5ca50b3e4e2d67bbe0946832d14cbb2aebbd06bf7ab4822045d01e8854ae7"
    sha256 cellar: :any,                 sonoma:        "fd15f87b6bf058ede160ef99bd78cc89088271bb2f73b86e575c5425028b484d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9625d86276c807b8da73dc55a419b7b67ffb1a53f262862bd70535cbfadcb2bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "757698fa6de683815867b10e7fa744c39af4daf079ad2c9d3908dfab7d2f6ebf"
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}"
    patch_spl_symbols
    inreplace %w[
      conf.c
      kafka_consumer.c
      metadata.c
      metadata_broker.c
      metadata_collection.c
      metadata_partition.c
      metadata_topic.c
      php_rdkafka_priv.h
      queue.c
      rdkafka.c
      topic.c
      topic_partition.c
    ], "XtOffsetOf", "offsetof"
    inreplace %w[
      metadata_broker.c
      metadata_collection.c
      metadata_partition.c
      metadata_topic.c
    ], "zval_dtor", "zval_ptr_dtor_nogc"
    inreplace "rdkafka.c", "EMPTY_SWITCH_DEFAULT_CASE()", "default: ZEND_UNREACHABLE()"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-rdkafka=#{Formula["librdkafka"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
