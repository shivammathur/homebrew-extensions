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
    sha256 "fc680bf757ef988fed8497486ee12679d0f75e8727b9d04a19aad0f14882e16b" => :big_sur
    sha256 "3aee64b097fb7905138b756fced9450bc913a8a2646d79843893022219fd2447" => :catalina
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
