# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT74 < AbstractPhp74Extension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-1.10.2.tgz"
  sha256 "0ebc61052eb12406dddf5eabfe8749a12d52c566816b8aab04fb9916d0c26ed2"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 1
    sha256 "2171efec5b1f651fe3b25c2e93dde003e3de640327b40ee00b893561eef4464f" => :big_sur
    sha256 "028837d09b38901482984f070b2f0c8dce917bb26ebc0f824d7ba6766ca0ae3d" => :catalina
  end

  depends_on "rabbitmq-c"

  def install
    args = %W[
      --with-amqp=shared
      "--with-librabbitmq-dir=#{Formula["rabbitmq-c"].opt_prefix}"
    ]
    Dir.chdir "amqp-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
