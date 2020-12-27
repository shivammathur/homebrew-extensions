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
    rebuild 3
    sha256 "4ba01971f464d8179a721cb4b66002e67504a2b51099b0c086baa10f80e73326" => :catalina
  end

  depends_on "rabbitmq-c"

  def install
    safe_phpize
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-amqp=shared", \
           "--with-librabbitmq-dir=#{Formula["rabbitmq-c"].opt_prefix}"
    system "make"
    prefix.install "modules/amqp.so"
    write_config_file
  end
end
