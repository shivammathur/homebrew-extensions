# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT72 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-1.11.0.tgz"
  sha256 "dc5212b4785f59955118a219bbfbcedb7aa6ab2a91e8038a0ad1898f331c2f08"
  head "https://github.com/php-amqp/php-amqp.git", branch: "latest"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "8a7971cb25a1cf330ec4b0ccda45cfeeb8778b0ffb2d6d5c55b8100994acd90d"
    sha256 cellar: :any,                 arm64_ventura:  "889dc1a57d87e0a3d34bf92e48c0dc4cf487f18ffc945c5f00378601b9514068"
    sha256 cellar: :any,                 arm64_monterey: "27e7415a4c78ca707d4d33278000f89a4bd3ecb76ff1cf92e25d0a78aad48c1e"
    sha256 cellar: :any,                 arm64_big_sur:  "d32540a8167ee54068488e1fac6164b42bbec054d2018f77e70f0bfba5a54a79"
    sha256 cellar: :any,                 ventura:        "d96785d9fecf72aa80ec81148c9ba347c4e24ecd316664755a2ebda14d44fc94"
    sha256 cellar: :any,                 big_sur:        "d663074b59a1738d97a5bdfea3b3e5942a2fe3fb61ee25e86536b6a5a24120f9"
    sha256 cellar: :any,                 catalina:       "181d1765597958f9942088b8e31e8539d9f070c012893863d9a6571a874860be"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "2cdd7c152d698191a58a2c6bd01e0fbfef619eeb1e6f51bdae5ac5856aca9a96"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c6ab20f50aabdd5c7771a68cec1357dd453792326bff3aae19beee8ca2533dda"
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
