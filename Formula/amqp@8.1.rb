# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT81 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/df1241852b359cf12c346beaa68de202257efdf1.tar.gz"
  version "1.11.0"
  sha256 "c9b27857fc7e39654518af5c35eb947b371556375550412b7166f75c03c8b5c8"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 24
    sha256                               arm64_big_sur: "e1fbfd0b5e0e30d0986f8029514a5c6edde8caec28713f413b24214dc1dea2aa"
    sha256                               big_sur:       "56b0165fa1f10115b926535acd2ceb67dfec3acb493d253d2e893d10e34f9b41"
    sha256                               catalina:      "d3b1979e6845bac1595882bec7b6a52fa6ae614397f945cad1796ee80da8b739"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0681734d9d6ddb524106868f3dfd03d6cbb10ccb53423b8d5b6ca7efa9c90450"
  end

  depends_on "rabbitmq-c"

  def install
    args = %W[
      --with-amqp=shared
      --with-librabbitmq-dir=#{Formula["rabbitmq-c"].opt_prefix}
    ]
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
