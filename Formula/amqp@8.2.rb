# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT82 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.1.0.tgz"
  sha256 "c3fffd671858abd07a5a6b12cb5cede51cc4a04fa7b3a25e75dc8baee14bce01"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "78639a832d9c40a2844a9e682c24cd0f5a455b005fcf498af8d48d6f1674e840"
    sha256 cellar: :any,                 arm64_monterey: "2992c066dc3153c5ffa4e2ea8ae482003daf4dc4cde29c10d17cebcc3f6439cb"
    sha256 cellar: :any,                 arm64_big_sur:  "8969c77152fb8379202edf04332ba3769b41d9301d6527e96d756bb0f6a09ddc"
    sha256 cellar: :any,                 ventura:        "238ba30e06bc0cefa1d4ab9095109884d5142010320cb1a73cd2ec5180581430"
    sha256 cellar: :any,                 monterey:       "131ae4b0b712b3fbf651650cb35551b90191888d7303330dfdc084938219e1aa"
    sha256 cellar: :any,                 big_sur:        "b6d5c02c7c00e182cb89c9bccfa54d3662c0e5b378d4bb00c3fcdb353ad1f845"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a3a9fb70500ec1ec6eec03b2310094bdddce4308f4bd244923aea3a935b238b0"
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
