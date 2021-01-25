# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT80 < AbstractPhp80Extension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/df1241852b359cf12c346beaa68de202257efdf1.tar.gz"
  version "1.11.0"
  sha256 "c9b27857fc7e39654518af5c35eb947b371556375550412b7166f75c03c8b5c8"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 "9efeee44c14d869dd22bceff42330175ee77aa8597b9ad9b9f3a7d68da5a8576" => :big_sur
    sha256 "b593f3cf1628ecb99c088a57faef030a5a658521cce61b71db2b2288f44244d6" => :catalina
  end

  def install
    args %W[
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
