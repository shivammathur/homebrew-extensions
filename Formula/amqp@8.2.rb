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
    rebuild 5
    sha256 cellar: :any,                 arm64_monterey: "c5edc9d300cd0c5886238593422aef022111d9e47ca4f8be08009085220f36d9"
    sha256 cellar: :any,                 arm64_big_sur:  "6c5b6ae4f72d6e41ccc6e0cc7327444908bdf583ab0f8896c9aa40efbcb04d16"
    sha256 cellar: :any,                 monterey:       "33aef02566da69c5b432b9e6aa46844f0e6324883d62278076b9f97a4754c3cc"
    sha256 cellar: :any,                 big_sur:        "5a12eef4f920eb4e66e5f656ac27ae9c0c032b76ccd9f4304ad9dd1f0a720e02"
    sha256 cellar: :any,                 catalina:       "88e0f9873edec630fa5d8c654c719e9e772f4a5be7e3bc4d307874f09af933fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cf372629b0e6d9b84fb76ceae6c9e898ef813523dc631b502f1fb2eb15a3fbe7"
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
