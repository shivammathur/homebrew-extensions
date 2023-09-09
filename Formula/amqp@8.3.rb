# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT83 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.1.0.tgz"
  sha256 "c3fffd671858abd07a5a6b12cb5cede51cc4a04fa7b3a25e75dc8baee14bce01"
  head "https://github.com/php-amqp/php-amqp.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "653c219388f187b82c0410c4ae5e6e208e53a6461f55c574b656813c7265e497"
    sha256 cellar: :any,                 arm64_big_sur:  "93f28248b4ea45ff71100c367553e30a60d6fe616f6a45c6a6ec7c6857264b2f"
    sha256 cellar: :any,                 ventura:        "529fa131cd7ee03b2e685909a466fba60897c7f3166c736578cb42b02280b9e6"
    sha256 cellar: :any,                 monterey:       "137d0c3670d39edf3a170de49290346c3b2c567fdb3f4be54f2840492ee143a4"
    sha256 cellar: :any,                 big_sur:        "45663868daef7691ebb8ade4612259314a021189790a07af3a03426b7360953c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "48785cae3cd7696e9c422756979e231b979f2a4b461b4fb9fabb9dbffa23a498"
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
