# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT87 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "0fc9a23b54010a9ba475a1988d590b578942dbdf14c19508fd47dd09e852ab0f"
  head "https://github.com/php-amqp/php-amqp.git", branch: "latest"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/amqp/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
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
