# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT83 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.2.0.tgz"
  sha256 "5ae624bd785e299523f6132c204bd562cc73066dd33a10a12aa96389f55a4de7"
  head "https://github.com/php-amqp/php-amqp.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/amqp/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "6a4b7b3da1125a6312613c7c338f35aea6f0629535fe3fd6af257ad5d9f1e3fd"
    sha256 cellar: :any,                 arm64_sequoia: "234c360d75cb4d212b3f3530606bddbdabeda15ca70c4b7f4e1c8ae1512ae5ac"
    sha256 cellar: :any,                 arm64_sonoma:  "75dfd1cd2b501c354217833cbc57684dac0adb90566eecd3b7484cef16966a40"
    sha256 cellar: :any,                 sonoma:        "0d79e18791cac59402dd0806789e8bc67141284f8eeb9eb9d13ccd20ef49e239"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "330bd7f070f70f984f3378546832fe9b0ef0c4b0b0aba61541173443ef6e8944"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1366420cc88a5843b854636db9589eb68d6e29eba808485da0f6fe6880946f3b"
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
