# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT72 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-1.11.0.tgz"
  sha256 "dc5212b4785f59955118a219bbfbcedb7aa6ab2a91e8038a0ad1898f331c2f08"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "d32540a8167ee54068488e1fac6164b42bbec054d2018f77e70f0bfba5a54a79"
    sha256 cellar: :any,                 big_sur:       "d663074b59a1738d97a5bdfea3b3e5942a2fe3fb61ee25e86536b6a5a24120f9"
    sha256 cellar: :any,                 catalina:      "181d1765597958f9942088b8e31e8539d9f070c012893863d9a6571a874860be"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c6ab20f50aabdd5c7771a68cec1357dd453792326bff3aae19beee8ca2533dda"
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
