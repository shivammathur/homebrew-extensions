# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT74 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.0.0.tgz"
  sha256 "2de740da9a884ade2caf0e59e5521bbf80da16155fa6a6205630b473aed5e6dd"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "7a935a9d1675e2be8144094ace1a97b8bd01e1b07448df896039ea22b9383478"
    sha256 cellar: :any,                 ventura:       "28281cd09c1adac8ebf75f208c5d59c6f8582c61ce846691a01dba22d471228e"
    sha256 cellar: :any,                 big_sur:       "304606252ecd9c31a6b9639d15f75f4c5cab6840a32a66ec1f74efceddd9a677"
    sha256 cellar: :any,                 catalina:      "906dcb8cb251b94b2f4d39772642e87607d281c7460d6f4cc5e4e414209a8eb5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "692fa0934d3d279cbdb45525b2c622ae214103c301fe25bf0fe5ce1ca3627ed2"
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
