# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT81 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/4090bd39b91c4ad8bb671f6b4c6161eaf89da3cd.tar.gz"
  version "1.11.0"
  sha256 "a0c40334cc0119727334b71ce236aee16e385e2ad087d7f98aa146f00c46a7e7"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 26
    sha256 cellar: :any,                 arm64_big_sur: "a36f399815fb35fc5f929ef961cf8a09aba697d407774c4762c1fcf09fe96e5c"
    sha256 cellar: :any,                 big_sur:       "e16b31f404936aa823745b92406cfb84f930cce6730b68cb0f0b47347349ec06"
    sha256 cellar: :any,                 catalina:      "b375fa1e506ccb216ae57bd014e3d2299a48c2eada24a1f49e67bfa6237c102e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6d719c3ebf394ae938b59de09fd41b56409b0ebb9776c44661bd6ccf34cf5c80"
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
