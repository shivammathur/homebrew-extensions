# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT74 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.0.0.tgz"
  sha256 "2de740da9a884ade2caf0e59e5521bbf80da16155fa6a6205630b473aed5e6dd"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "8e7ffe26f589b2c175e3c29ca2fa94e985b8de03ac4a5601ccfa811198fc8e90"
    sha256 cellar: :any,                 arm64_big_sur:  "ef28e7dad41bc9b6e41ede59fb24df263cbe1311bf9b18ae7c3cf8ec6976e4fa"
    sha256 cellar: :any,                 ventura:        "78bb583c91ebf401c999e2d176e7b54ddf5af922030a43ab12baadffd4736132"
    sha256 cellar: :any,                 monterey:       "c63eaa33c557049b5f53014c8b44c5ad72246b008ea71fcc9e603671b992ac45"
    sha256 cellar: :any,                 big_sur:        "548bd901e730a357bc7bb5b714d037d02be071b3298f3ec4da5f62eb0635ce23"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ef780ad7313e11e112908acab88dea20f02a8e610f15de2ac432a6d25e575179"
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
