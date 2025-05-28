# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT73 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-1.11.0.tgz"
  sha256 "dc5212b4785f59955118a219bbfbcedb7aa6ab2a91e8038a0ad1898f331c2f08"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "2e72b1e77e503947f6cdc364df2e9020f723d24604a48bbe15eba02dcec51940"
    sha256 cellar: :any,                 arm64_ventura:  "01f69ec25c76c0a0eb93f3842ff3bcd8cafa9de85ed08ba2ba0fcc3fc0c1150f"
    sha256 cellar: :any,                 arm64_monterey: "c16fbf7aa06700ec67b23294ccb3a46fac8139b4fd0acd0393937cf82ad57d8b"
    sha256 cellar: :any,                 arm64_big_sur:  "30b27717f0562784be0aa8aecaeb1f6b73497ed50dfc9c61a863baabcbf7ad48"
    sha256 cellar: :any,                 ventura:        "dec315a303c520cf92498cc3ea0eabb462442dfb623effa8d16331aef8ceb6b2"
    sha256 cellar: :any,                 big_sur:        "38f49ed23c14ad73ca38cbe6d3963b300814d66e9cb785e04f41a4350b43804c"
    sha256 cellar: :any,                 catalina:       "314bf7de613f2a3bf4ca1fdbb3aa407c73a6f82de2bf665168607b3a9957dbcf"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "22b23edd2a370dd3d9a48c3438224afb530997912190be9c09c086049817d2c0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a3f8b4d3dde1e5b9dcc6dd2788c414e1ef401d8afe40706961dc40dd1e1fee3f"
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
