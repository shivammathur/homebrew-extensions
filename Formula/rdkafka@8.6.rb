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
  revision 2
  head "https://github.com/arnaud-lb/php-rdkafka.git", branch: "6.x"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/rdkafka/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "cfa4f4b3fa4b1963e002716aa83a7759cc030be47ab6229bd18c78115d3132f2"
    sha256 cellar: :any, arm64_tahoe:       "e864e1186537eb222bbc280139e5e03b04d45a095f21808af86bdfbdd1dc470c"
    sha256 cellar: :any, arm64_sequoia:     "2cdc8c6288ff5eb6e43e2a31d35f2818307f794f24a1e274d27258f68289171d"
    sha256 cellar: :any, arm64_linux:       "73f12807d046036bd9cb40561be4aaed2cab77da546a69491eeb539dc1f3a75d"
    sha256 cellar: :any, x86_64_linux:      "b387c7a8f5cda963699ce87449bb81f2afce49573efe91dd2270de7858f3012e"
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
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-rdkafka=#{Utils::Path.formula_opt_prefix("librdkafka")}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
