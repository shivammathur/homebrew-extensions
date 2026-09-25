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
  revision 1
  head "https://github.com/php-amqp/php-amqp.git", branch: "latest"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/amqp/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "f53fb3acd82dfb560dd7ad3634e9691febc856388151bded6f8b0a76cd489ad1"
    sha256 cellar: :any, arm64_tahoe:       "3b9a31e1b69883cc7db1b9c2d770951ec292b35dd2625f30cbc8b7ed3121a166"
    sha256 cellar: :any, arm64_sequoia:     "c6f6681e41dd5af18dfe427a594c0fca4ccb168b748f97c651c5acd09680ca3a"
    sha256 cellar: :any, arm64_linux:       "1663ea10e96778994117da2d66d9cf338af92c30d0930c7230dae964ae583c16"
    sha256 cellar: :any, x86_64_linux:      "a15a5bcfcd5c1582cc052036d3f6cd39462f0a19ecd4faf27f0f09af4936517f"
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
