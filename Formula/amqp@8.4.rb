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
    sha256 cellar: :any,                 arm64_sonoma:   "6e05594c71731c69c2459bb909ded7858efed58f007bdaa82ef75dc5fa3e23e6"
    sha256 cellar: :any,                 arm64_ventura:  "708d8cccf5b15cee8445c0099bef5a3ffe8d24401c27874bb9c21f18910393c3"
    sha256 cellar: :any,                 arm64_monterey: "e2b946d9d515766e21b8e77411a7e85718dd4f27cf4f86899a96dff8155c3fbe"
    sha256 cellar: :any,                 ventura:        "6e088c25bcc6a4034d3c8a8901ac870a154655f9f47b47944dd516ae3e2f3a1c"
    sha256 cellar: :any,                 monterey:       "303efc7b6c126eb4d39550f0039e38ce0201298f51d642e1a10d5c5a61275fe1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f896c875b60a34c635b79f4c1032d582697b63957e60229670d4b57e9e07ea8d"
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
