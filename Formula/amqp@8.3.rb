# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT83 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.0.0.tgz"
  sha256 "2de740da9a884ade2caf0e59e5521bbf80da16155fa6a6205630b473aed5e6dd"
  head "https://github.com/php-amqp/php-amqp.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "d6acdd210774acd60388f6e559bfae301d12d4a901e92256b0fd415004fd8104"
    sha256 cellar: :any,                 arm64_big_sur:  "566bd3d706b070eb29e37727f768cc439175d10f3e6606653a459c25ec9fb371"
    sha256 cellar: :any,                 ventura:        "fe3f2e4850721ec8e492c239351147cc96895744a794a1e80e6cdbb3ed5b3e5f"
    sha256 cellar: :any,                 monterey:       "793747bc2c4e651e26bd8d4da0364a97a6e8248ea3abf6c30be084a348cc42e4"
    sha256 cellar: :any,                 big_sur:        "ca1873dbb12b5e178d92df56cbc5a69757d2da14b470f21472abdf70d6d6f621"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6722031701433afc88f0c2d753a2baf4390aa437bacbe5a1f63f95e22eda7e20"
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
