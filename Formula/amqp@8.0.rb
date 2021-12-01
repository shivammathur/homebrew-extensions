# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT80 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-1.11.0.tgz"
  sha256 "dc5212b4785f59955118a219bbfbcedb7aa6ab2a91e8038a0ad1898f331c2f08"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "faba492a4b63944cd4b17d6effd5502cf4ef34a0bc2e734a26d04696b378e086"
    sha256 cellar: :any,                 big_sur:       "81c6d52478a7a61b124d9fc2dc3f763294be6e9f91cd0ed92bd4197b673edd69"
    sha256 cellar: :any,                 catalina:      "82647666aeae812a9e92fa85005d111ab92a7451bdd536cad43f85798dcb9816"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "607862e7041efce276dd26dc8b071f5df371bbeaeab314f676b497fafaec2951"
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
