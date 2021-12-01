# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT56 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-1.11.0.tgz"
  sha256 "dc5212b4785f59955118a219bbfbcedb7aa6ab2a91e8038a0ad1898f331c2f08"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_big_sur: "6757756e5634061cb558900db06b30be00d7c2c70e13c3ff6a0edc50f3edc59a"
    sha256                               big_sur:       "d596e7101a2f74932025879ddf775f0dee63bf7ea94b705011bc54d49e3259c7"
    sha256                               catalina:      "f024a45a21351fbf4656722032c2441217318688da49b1dba48dd629b92351d0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b6a500e1a0e42bb42ae30ed491f504e8c0c1190513ed1bb3bb242bdcf42769d0"
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
