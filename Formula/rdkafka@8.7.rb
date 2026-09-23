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
  head "https://github.com/arnaud-lb/php-rdkafka.git", branch: "6.x"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/rdkafka/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "59f56723069ef58eb7b82416cac2dd94ff158926bbdfff3165b2df5b39ccaebb"
    sha256 cellar: :any, arm64_tahoe:       "d9a4c621ad8d1e3e017eb95804ea602d406906cc1306fbda05f59b74bed6c008"
    sha256 cellar: :any, arm64_sequoia:     "aa8ec21a184adaefad5a9413d03cb239c70fb87feeced46c65d9f1595376b9da"
    sha256 cellar: :any, arm64_linux:       "64c07c41d3d0c92bd819ca71895ce94b19e2c76666e24170c07fd718274611ae"
    sha256 cellar: :any, x86_64_linux:      "c11592034933ab6eecf2342d95a6785eeec949fe83dc9263df335b271cfb5c08"
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
