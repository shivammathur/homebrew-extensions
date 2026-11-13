# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT87 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "b6fff6876b66df926451cb9ed25dd574a6f7ce3a3700e9ca90846e0e4e90f6a2"
    sha256 cellar: :any, arm64_tahoe:       "33aeef2735ad9fe34f14118b63916b63f4c594a75ed3620f36f2134601ce51ee"
    sha256 cellar: :any, arm64_sequoia:     "6670453025d6fb2223110868fe24e09d6e7889ee07f920be4216f8bb96b4ae64"
    sha256 cellar: :any, arm64_linux:       "289bacca920ca385eec10c8b7a2bb936b546715ded61502c7de84d5f40ffab03"
    sha256 cellar: :any, x86_64_linux:      "735c57de23521144cfb3f0fd55ebd74ca7854c51996d85d5e22454adbcc5eedf"
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
