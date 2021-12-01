# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT82 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-1.11.0.tgz"
  sha256 "dc5212b4785f59955118a219bbfbcedb7aa6ab2a91e8038a0ad1898f331c2f08"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_big_sur: "b358f7e8fbf82dc2d90bb1c265eb43515fc08116dad4356934705f6cb16a8638"
    sha256 cellar: :any,                 big_sur:       "3dd685001f0bed728ea4f740b0264304eabd8109e847ec4d5b694b63b6ca8f67"
    sha256 cellar: :any,                 catalina:      "89698c2bf0314bb91b2f1256be7b50360a76d6175ceb73009139338962e54e10"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7f937dbb91211a8ec331c95ca95f07edc47e26aa80fc43f4f3ebc8ac6207a715"
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
