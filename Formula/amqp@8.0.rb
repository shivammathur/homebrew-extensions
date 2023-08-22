# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT80 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.0.0.tgz"
  sha256 "2de740da9a884ade2caf0e59e5521bbf80da16155fa6a6205630b473aed5e6dd"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_big_sur: "07a0c6b027cf380ac39ecdb14838227bbbe7953a086bd8c7394b2f2c337bca4f"
    sha256 cellar: :any,                 ventura:       "6e095f38076c26fb2bcf0bbe5baf89a94a785e66ca32e5f3700b1e7a6898470a"
    sha256 cellar: :any,                 big_sur:       "e916f1402b9d928bdfc56aeb8348ee5bfa4b82f4c1347b2b6c3e44ac1b3f38b0"
    sha256 cellar: :any,                 catalina:      "bce370ae19e11439e4fecce007dc3ac3e364302adc0af2df9c16afc5734c64bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8d6d1d83aa07d563c25b3cf5273a9cf436070ce130484613cbf2237f71181e8b"
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
