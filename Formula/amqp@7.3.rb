# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT73 < AbstractPhp73Extension
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
    sha256 "82ec99c41c57a7c3b089abd47cfc77e32fd9acf1f375d7f7634d94d2edfc115a" => :big_sur
    sha256 "69fc934f840d5fbd5f05dbf6b50942a8730caa8b7152c40c0ba2c4b238fbae97" => :catalina
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
