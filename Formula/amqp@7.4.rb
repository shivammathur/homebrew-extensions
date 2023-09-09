# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT74 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.1.0.tgz"
  sha256 "c3fffd671858abd07a5a6b12cb5cede51cc4a04fa7b3a25e75dc8baee14bce01"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "65252d3e98978776d839bc490feedadc3cfdebd57d547db123af9970301ff8b0"
    sha256 cellar: :any,                 arm64_big_sur:  "0bafb148ce248a738e54c6067f2fa683650537620491935175d4a9cc9e803502"
    sha256 cellar: :any,                 ventura:        "e207909aa7f6c49d5b7a1abb8f187c039d962da3527518a739a6b7ca640bf3c7"
    sha256 cellar: :any,                 monterey:       "ae0ad8f3cc03a2b504c74a64b58cc118143720cd9377ff984f334c2bec81fd03"
    sha256 cellar: :any,                 big_sur:        "9312864acb4ac15ca33519a5f9c5ebc3c8fb84b259613bd24e8c963c203b0cd8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "16bb2204c4c1c62de08232c0a0cfe8f3fb198e0c5b1b16b49f8dae1602b297a5"
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
