# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT81 < AbstractPhp81Extension
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
    rebuild 10
    sha256 "a2c72f2a5e807d65fa0639ce886321ae97f405cccd2193665f68aee22e1d4643" => :big_sur
    sha256 "5b5c553abd0c01fc8a5ee9cc5f1e81c6a0e9b57e5533d1ad078ea4cf8bc71de0" => :catalina
  end

  depends_on "rabbitmq-c"

  def install
    args = %W[
      --with-amqp=shared
      --with-librabbitmq-dir=#{Formula["rabbitmq-c"].opt_prefix}
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
