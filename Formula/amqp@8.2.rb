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
    rebuild 6
    sha256 cellar: :any,                 arm64_monterey: "ce4f55d754ccb689fd93b5319efe72ff03e5b6b8026eca7409ab6279997ac0d4"
    sha256 cellar: :any,                 arm64_big_sur:  "bfce5dff5d5fe7410de65f9aed16312b9ca396e6bcc4432e4e042a2b056cff32"
    sha256 cellar: :any,                 monterey:       "2d2bdcb1d393171692d2be1a5893e20ce6e559014980db1321994c6c1095adfa"
    sha256 cellar: :any,                 big_sur:        "6c4a0cdc5ce976864a0335432934be03020ae54915bd733ec1c92ff5985f861c"
    sha256 cellar: :any,                 catalina:       "5e5b7b174b4b6da882d07a16a3c521b984765675181837c7add3270fc92cc3b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4ce7f2321847cd4589c01691b53d6ab00f301f25a84eaff2d68ca7b47f7cf84d"
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
