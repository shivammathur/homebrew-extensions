# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT86 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "0fc9a23b54010a9ba475a1988d590b578942dbdf14c19508fd47dd09e852ab0f"
  revision 2
  head "https://github.com/php-amqp/php-amqp.git", branch: "latest"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/amqp/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "8b89b083cc9dc8992cd924caa7ebcc13b90e99cd1216b41428f3662fa61a7f63"
    sha256 cellar: :any, arm64_tahoe:       "a35422d198424e049daaaf57f0d2a9530ec9361f03c289e9b91def27af769b9b"
    sha256 cellar: :any, arm64_sequoia:     "392b37ca21a0b01e0221501823b48e89679f2233890e5e69386b77260466b1d7"
    sha256 cellar: :any, arm64_linux:       "70cfd1deed6cc65c9c5a4435c7a505e48608fba54e6f8b3447c6e685ab0c6c7e"
    sha256 cellar: :any, x86_64_linux:      "aaef45d51da81503f797092d8366bcbaa17af8bdba1ebc1c9b97a65e36fdf277"
  end

  depends_on "rabbitmq-c"

  def install
    args = %W[
      --with-amqp=shared
      --with-librabbitmq-dir=#{Utils::Path.formula_opt_prefix("rabbitmq-c")}
    ]
    inreplace %w[
      amqp_channel.c
      amqp_connection.c
      php_amqp.h
    ], "XtOffsetOf", "offsetof"
    %w[amqp_channel.c amqp_connection.c amqp_queue.c].each do |f|
      contents = File.read(f)
      inreplace f do |s|
        s.gsub! "INI_FLT(", "zend_ini_double_literal(" if contents.include?("INI_FLT(")
        s.gsub! "INI_INT(", "zend_ini_long_literal(" if contents.include?("INI_INT(")
        s.gsub! "INI_STR(", "zend_ini_string_literal(" if contents.include?("INI_STR(")
      end
    end
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
