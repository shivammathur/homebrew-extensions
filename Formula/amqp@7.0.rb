# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT70 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-1.11.0.tgz"
  sha256 "dc5212b4785f59955118a219bbfbcedb7aa6ab2a91e8038a0ad1898f331c2f08"
  head "https://github.com/php-amqp/php-amqp.git", branch: "latest"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "bcdeedfb0e9be37a489da2229fd017a259b43bed439af6fa843c2a35b6814e9a"
    sha256 cellar: :any,                 arm64_ventura:  "c5f402bd674c350350969aa81f55a88a88dd95c5e177fa4802b7ac0c783ef531"
    sha256 cellar: :any,                 arm64_monterey: "dc0feb5b9e1c6924ed9d75c5f09991f78a9d744fbc4d3fff5a187b3a4aed2fca"
    sha256 cellar: :any,                 arm64_big_sur:  "1f7081546c3a6c1ce2c088753d3efd938fe56ec9d966fc04f52b05e885d2f0ea"
    sha256 cellar: :any,                 sonoma:         "2c45b586d8aca9e6dae4573fcafa1852bfe59108406854bba93e7fde2b4d8380"
    sha256 cellar: :any,                 ventura:        "93a09802aabe59e8f7f60338b3cc8da19d10d0e2c12b75a9f33a976ed2c56d19"
    sha256 cellar: :any,                 big_sur:        "f04fc1becc03867499f7966dd74368796e4d5f47c6ca91a917c3fb059b31b5d0"
    sha256 cellar: :any,                 catalina:       "4be6f8e37bb39f8121f6e577cda4bc1e2548564a5f38047f15797ddb32b36400"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "28fe0d66b112cf73619d51d97e27d75f84c7b843e46a012828b90450aa9b83d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "34fa4bfc67d8ea8acae340ef2062c94973fc5d8a97bc79ffd17297dde14c6c42"
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
