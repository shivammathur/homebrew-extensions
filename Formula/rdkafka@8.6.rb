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
  revision 1
  head "https://github.com/arnaud-lb/php-rdkafka.git", branch: "6.x"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/rdkafka/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "c03e4476e94769628aaa0d9fe0e603cc94d8c5732188f81a1bed0b3de39c0ee3"
    sha256 cellar: :any, arm64_tahoe:       "63da39354f2a2393af94bf366c92b276998404041111d2c8268b64a9c667b650"
    sha256 cellar: :any, arm64_sequoia:     "1e825bb3478c9b8a5c8bd3eb8a8dbd8025de812079d819c351316c692739b4bb"
    sha256 cellar: :any, arm64_linux:       "364b68a36881ffdfebab9daa0348241cf27d3b74090a4c31974ca9805a3bef00"
    sha256 cellar: :any, x86_64_linux:      "7f78237acba3ac83226483691fed4f78809f1086542ffa793ea4412dd5557d8c"
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
