# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT84 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.1.2.tgz"
  sha256 "0cb16d63752a0055de55a22062a6c1744908696d92268d76181284669025d993"
  head "https://github.com/php-amqp/php-amqp.git", branch: "latest"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "cfcf30abc1c6b6cd4bb7301d35e200749fa9643a99d857ff231a46b963b0d597"
    sha256 cellar: :any,                 arm64_sonoma:   "c1dd4a1e88cd5a37bc4b09bc8b188ef3feb3c0b648b0a2a9785a5d69e1823e74"
    sha256 cellar: :any,                 arm64_ventura:  "1f327de650c774f12e24686d37be024cb949c2f66607b0031f467c4c3ee34727"
    sha256 cellar: :any,                 arm64_monterey: "4e10dbd0720f7947cbe85c6dd9804c730140749c5d56d1bdec5ef9227314f5b2"
    sha256 cellar: :any,                 ventura:        "938a9b032f6fd12a60646b4419745947b817b2146b3853654afed38c1c50796b"
    sha256 cellar: :any,                 monterey:       "68e928e1391afd0624b108c7971bde6ac0978bab5d3bcfc2f55a68fe7684da38"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b4d1dcd12134bc4fe89b8d3c8549e846a1175adc91b87cce25e18e87b02cd4ec"
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
