# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT83 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-1.11.0.tgz"
  sha256 "dc5212b4785f59955118a219bbfbcedb7aa6ab2a91e8038a0ad1898f331c2f08"
  head "https://github.com/php-amqp/php-amqp.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "9a12d20a714a3290cde46d02396b370be653ff9d3fd9b05615573177297be188"
    sha256 cellar: :any,                 arm64_big_sur:  "2beff8c729e849dd268b1ac4f7fc32e67a6d0246aea66f9da5649a3deb1cb3e8"
    sha256 cellar: :any,                 monterey:       "42880b021a955f90c65c44c977c5f2eca5d367234f4c1c6e3ba9893a2fbc0c50"
    sha256 cellar: :any,                 big_sur:        "46ebf0f15487003839b465f1548391f03cc616fc12e588c7015f0fa30dd27af9"
    sha256 cellar: :any,                 catalina:       "9a01a8316ed661a9ed2fc39ee6aaeaf855fdc5b79f1aecd36cc947414ffd7930"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "18dd767a6cfa7a71c07127ab4d1b430b77297e210e5b0b0159e6be4f27664b95"
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
