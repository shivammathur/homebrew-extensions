# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT82 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.1.2.tgz"
  sha256 "0cb16d63752a0055de55a22062a6c1744908696d92268d76181284669025d993"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "735e20220d99430f9fa8743f2cecae7f53df17a28614bfe0cbbeebcfcf0b88be"
    sha256 cellar: :any,                 arm64_ventura:  "977ee802f947bbeb973316b080972e7aea1c31100f0d6f03ccc8114f17f50b14"
    sha256 cellar: :any,                 arm64_monterey: "fecbd9ea5041c814d31dc4a4a721d1518bc60bc9c5c80bae9f4a1384003e1e08"
    sha256 cellar: :any,                 ventura:        "e1d050ae3c2a5b4f5c8d3af189e30bbc4e4ef7f0f2890a963a9e2f9ca843d7ba"
    sha256 cellar: :any,                 monterey:       "7813177b21bbabeee0794eb6c5379edeb7c6903a6c26728e013d8418b3c15191"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "61940e5cd3a7c7475c62f365e4aa9870990894039ab4e3a8d503f08c082d7664"
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
