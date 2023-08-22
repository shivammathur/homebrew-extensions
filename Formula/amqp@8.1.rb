# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT81 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.0.0.tgz"
  sha256 "2de740da9a884ade2caf0e59e5521bbf80da16155fa6a6205630b473aed5e6dd"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "4fa667535d755cb9a1583e61cb5f3dd186656c9dcdcdc913bfe1d1fde0cb72a2"
    sha256 cellar: :any,                 arm64_big_sur:  "95641d5e8e212dc3e3bd9a951780e80ec7902f4816c08125d255e32b7a981052"
    sha256 cellar: :any,                 ventura:        "3f47bb36ff2f7c98276b4924b78af8e359c17ac797105bdde207255b933181cd"
    sha256 cellar: :any,                 monterey:       "19494f8803476f7b48c2eceb3b5b1c960ef8824ddc06cb681ec916c6b3775874"
    sha256 cellar: :any,                 big_sur:        "c62f6dd3ca66914f5695f550ab5dfc9a3e648bf6dba3b9d7977b66340ed14bd2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1a57ac4cd64af93224d69761d3fc5e965e768c809be436758e6a876368591eea"
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
