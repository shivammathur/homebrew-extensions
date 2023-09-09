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
    sha256 cellar: :any,                 arm64_monterey: "39b78b7cec9bfe2a66da8ff4bfeaa2db08200cfee40e7a83bfc4d5dd2c0d3834"
    sha256 cellar: :any,                 arm64_big_sur:  "0a13c670bf53d719316811babb7924fae3d594c4eea104c9d752086b4270f35e"
    sha256 cellar: :any,                 ventura:        "2915f41b48f9c8b2bbb58a7d0eb2408c7fd923b77c6115042ed34b467d3f4943"
    sha256 cellar: :any,                 monterey:       "9a2ccd36966745853d82387e0dd16ff1ec586d837c9003b6f423b04f9ab3a7df"
    sha256 cellar: :any,                 big_sur:        "993ff2e463dd4a1086793f4a4e35c1c51710dc153c841b5187502a8d7e2abfca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "603d7616d661e5add81ff43ce1f5633e32337258e689749feaf4ba7e4d224264"
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
