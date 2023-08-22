# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT82 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.0.0.tgz"
  sha256 "2de740da9a884ade2caf0e59e5521bbf80da16155fa6a6205630b473aed5e6dd"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_monterey: "2b3fb2283ef33752738713265e9b3abbb5b834ea858ecee2399137bb5ab1c8ac"
    sha256 cellar: :any,                 arm64_big_sur:  "c800d42314f8f4ea500c9e788eb9ac4079e904e3fb5c446fdebe7c89546333b7"
    sha256 cellar: :any,                 ventura:        "8042d6ee4e7fe5f0917125c67ef040aaecc9e8a9a79f390f50ae3bc81ace5f06"
    sha256 cellar: :any,                 monterey:       "af3ce5c8ae9a91031d4d986c7cadce4062e49bbe5c31f1bfa8ebca1f210c996c"
    sha256 cellar: :any,                 big_sur:        "9f731ac3df0f9e23f715c0e5ff9ed00392d51a8d8af315a089487cfe6ba637a0"
    sha256 cellar: :any,                 catalina:       "0e76f55ab9113f9ced2f14cad759c13261cae032de574f8c3f7ed5626c542a48"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8175add7bcc1b1581bed2c866260874bc87e6bc6eff482d40feb7ea406090667"
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
