# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT74 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-1.11.0.tgz"
  sha256 "dc5212b4785f59955118a219bbfbcedb7aa6ab2a91e8038a0ad1898f331c2f08"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_big_sur: "fdd02daa69cce327dbc96f9e387dba9272ad81ddce47a28223863b902a4ae136"
    sha256                               big_sur:       "2171efec5b1f651fe3b25c2e93dde003e3de640327b40ee00b893561eef4464f"
    sha256                               catalina:      "028837d09b38901482984f070b2f0c8dce917bb26ebc0f824d7ba6766ca0ae3d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6ac3ceb1c907c6129bfcf1e1ce6df1569506317b6c620eddb42154ac00fe9355"
  end

  depends_on "rabbitmq-c"

  def install
    args = %W[
      --with-amqp=shared
      --with-librabbitmq-dir=#{Formula["rabbitmq-c"].opt_prefix}
    ]
    Dir.chdir "amqp-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
