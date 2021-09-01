# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT82 < AbstractPhpExtension
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
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "3d5fd1cf07a3244fe3897f8fe48d7271976af569d29dcdafa6d0d0e066a38d92"
    sha256 cellar: :any,                 big_sur:       "13203de849d34a257b2a59c7b287a127756fa0087c31a536f8adab9841f4fba5"
    sha256 cellar: :any,                 catalina:      "46474c1aca9334a479a3de98d36b6e0ab36f91d704e8766f922edbff4959a0fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e91c686449a5e99b0e29dc36d72e2cef4fb0e94067a5f1da2fc96840315992da"
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
