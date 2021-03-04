# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT70 < AbstractPhp70Extension
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
    sha256 arm64_big_sur: "417f92f7680a9d8310a8f1bdbfd933f97119b4d66f6766076d3f99487ce12bab"
    sha256 big_sur:       "c4f1fe3c7802dfb0d5e683e22e5eb0e1c357e257e8abb76f31c3a5cdc52f8503"
    sha256 catalina:      "5911553ddd34b9d56a095f9e9c19b5e51e80c048838ac75e7639ff215f38ae79"
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
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
