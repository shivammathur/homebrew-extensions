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
    sha256 cellar: :any,                 arm64_monterey: "e2f45a80af10fab8b5709c13e2b3c778c7ecc321a4fc09824af5eeb3dc8ff7d6"
    sha256 cellar: :any,                 arm64_big_sur:  "34cf3d57a192a7d8aa7dafeb3d63891cefe8a853712e7249b7cd63e0fc499f93"
    sha256 cellar: :any,                 ventura:        "035cb2cd1609aef768cf927197e7a73013ae3679c39827926931a3a953cd6524"
    sha256 cellar: :any,                 monterey:       "922b8688146dec14a6d1f32c7edd856918d3c1f48c5dfc97e96b409bacbc07b1"
    sha256 cellar: :any,                 big_sur:        "45a072fd73796e5c9d1f948a78f6b65294cc73ae96c45e163b51a29dac56e630"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0ad2f429c6d0937fdadb21e4e7d9636e71b480f4a16f8c75a39de89e6da61e63"
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
