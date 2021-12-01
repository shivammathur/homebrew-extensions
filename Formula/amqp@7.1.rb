# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT71 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-1.11.0.tgz"
  sha256 "dc5212b4785f59955118a219bbfbcedb7aa6ab2a91e8038a0ad1898f331c2f08"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_big_sur: "e2da087bef1b943a869b0c21abf890b108a44f59ab0949e3d64b8cfb509efcd3"
    sha256                               big_sur:       "6f4ee43df8601cb43291f4419fc3dee35574a73a702625d48f16b4ca4dd17e71"
    sha256                               catalina:      "55a487f4915f9389d5d9a0c153694ba6bd48eb0cb5163ca4b2832cb33cf6603d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0d7022ed09796403d9aa717d58dd85b5cd33d253c08e0fb4add63f2c46444538"
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
