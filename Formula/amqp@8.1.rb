# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT81 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/4090bd39b91c4ad8bb671f6b4c6161eaf89da3cd.tar.gz"
  version "1.11.0"
  sha256 "a0c40334cc0119727334b71ce236aee16e385e2ad087d7f98aa146f00c46a7e7"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 25
    sha256 cellar: :any,                 arm64_big_sur: "29c309770ae7dee79a234cd88416b06545593e0512d7615911e02767ff0f3ebc"
    sha256 cellar: :any,                 big_sur:       "208f097c30a3554d2811904fff306dfad50a989396c52ccc361ed555752457da"
    sha256 cellar: :any,                 catalina:      "e0ddeac93e5158d10061274c0cf1480ddfc9023c30d79d370d98d9f753ab4bac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "64477de7943eea773d3b79f57e4de87f5b435e9b49e8c8ec2991584613583c26"
  end

  depends_on "rabbitmq-c"

  def install
    args = %W[
      --with-amqp=shared
      --with-librabbitmq-dir=#{Formula["rabbitmq-c"].opt_prefix}
    ]
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
