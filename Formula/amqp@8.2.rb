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
    rebuild 4
    sha256 cellar: :any,                 arm64_big_sur: "01ae28863c899c5410954f55478c27ef5a8f7bd6aba9ea8eceb687c1bec2a9ec"
    sha256 cellar: :any,                 big_sur:       "dcc17043f854e97f87928d56664b49bd45a670661c751321b8896f60cc364692"
    sha256 cellar: :any,                 catalina:      "8ca9b3cefae96ce5ade81460a1d9972466e8784c51bdd4fb14122ef2e4a333b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e82cf4894948c213b85468d6e95d852456cc36139d43d48b4fd713c111d7c254"
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
