# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT84 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.0.0.tgz"
  sha256 "2de740da9a884ade2caf0e59e5521bbf80da16155fa6a6205630b473aed5e6dd"
  head "https://github.com/php-amqp/php-amqp.git", branch: "latest"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "9d397ff9bca9e9e0670ae2d4fd266fc3946917c5204073f40e56d6ac01392f87"
    sha256 cellar: :any,                 arm64_big_sur:  "b62b57312adf9d97e7a8c832510ee4793e8cf4ff3d60ee341087f0e691d16625"
    sha256 cellar: :any,                 ventura:        "832b459a1046d229521db8367f8556c59dc966d4edf46d4aa029ca3e5d42d96f"
    sha256 cellar: :any,                 monterey:       "f01392b0959d7741c40e3e0a2fd0620b7634d242d3ace2149126d7a1e49a94b3"
    sha256 cellar: :any,                 big_sur:        "6a6a5b57a293228793720aef0711d336b3b7ba30f806dee5b4ca9d9f5fc27dca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ca47f0d4e630ec84e19fd186d74ac26e178244d6c3b3a11a3b2a6e49c93473e3"
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
