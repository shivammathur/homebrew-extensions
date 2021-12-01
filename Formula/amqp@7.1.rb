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
    sha256 cellar: :any,                 arm64_big_sur: "fd58e3a33b71521431d97a8455a4247e5908cc1639f780d2c585eea33d1f38ea"
    sha256 cellar: :any,                 big_sur:       "e484c73c44cc9a847585d32f3d990ff21307871f8c37c5e314537c5ea0ab83e2"
    sha256 cellar: :any,                 catalina:      "80dfdbb590e50a5c377fe82016217bb9068389bce72c067a2bd25e6764d5e343"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "87907253e94fe8f69a8e1eb13b90ebf57235e55e9146953eddb2582f23b6a6c2"
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
