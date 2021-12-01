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
    sha256                               arm64_big_sur: "761762d7af8fab7915a515ef6eacbf99d32fd7f20785c9ea7832ee8a14fb1abd"
    sha256                               big_sur:       "0b6ae08cffc32f06e0ce6f2d66d85310d1d1cef71737969917f616f23086a0f9"
    sha256                               catalina:      "504bcce9042b0867982e1e34a81d5326109a8519294b38283335bafbd6f06c01"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "63fa576071a024accaf200ffc0244189b2cebb229e61ef259da998ff93d77408"
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
