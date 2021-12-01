# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT81 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-1.11.0.tgz"
  sha256 "dc5212b4785f59955118a219bbfbcedb7aa6ab2a91e8038a0ad1898f331c2f08"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 27
    sha256 cellar: :any,                 arm64_big_sur: "5b68df55ea3313754fcbd2a8f40961d33501005d141db018313246f407e574c6"
    sha256 cellar: :any,                 big_sur:       "cf4bc6e440e7a1ffe68cd8f222c16ea1fd087ac992b273023f1533aa03799d7d"
    sha256 cellar: :any,                 catalina:      "7b0ace5ba606dbbff7ee968daae28694ebdf1dcf7d4770c4c0f57d2e786ed74f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b4c414c8a4559790b214105fce78d3dfe2a148ee66f9c816b9446198410e5e6e"
  end

  depends_on "rabbitmq-c"

  def install
    args = %W[
      --with-amqp=shared
      --with-librabbitmq-dir=#{Formula["rabbitmq-c"].opt_prefix}
    ]
    Dir.chdir "amqp-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
