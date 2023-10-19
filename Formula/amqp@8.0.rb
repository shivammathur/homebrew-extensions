# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT80 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.1.1.tgz"
  sha256 "c9b36f10c2e7b7da472440e21c35655c3bf41983b99bf1e438eac7d5bb1c2b45"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "37f746f6aa8d0a5699e29648879705085eacf5efd200bcd2d0e71962d1547426"
    sha256 cellar: :any,                 arm64_monterey: "df28979060666f4f0b9d39a47b0bb6ca10688d69cbbec20720fcfab44e105930"
    sha256 cellar: :any,                 arm64_big_sur:  "da5f88c0b1c6962183274a55c4076211ac58d92c13d947bddfe2e88e01b42338"
    sha256 cellar: :any,                 ventura:        "a109d04e420cb5291004f17f4ceb895a0c81ae9117beeac2267c4c4af2fc2f99"
    sha256 cellar: :any,                 monterey:       "6a65586475e21414d1cfdb783327c534939bbb09d83baeac6c0343cd12b72018"
    sha256 cellar: :any,                 big_sur:        "5a90bf4b3eaea36294288e150eb6e70c688918b4dc6941bca65f07f93bdd1086"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5f9c46ab822b2cdf03bc79e4f35bf25573301979e3e463d8f8b7acdc8303aebd"
  end

  depends_on "rabbitmq-c"

  def install
    args = %W[
      --with-amqp=shared
      --with-librabbitmq-dir=#{Formula["rabbitmq-c"].opt_prefix}
    ]
    Dir.chdir "amqp-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
