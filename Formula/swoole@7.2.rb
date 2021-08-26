# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.7.1.tar.gz"
  sha256 "0fc700c8ea65ecf5247c7394a49b1f211e4a419987dd50adc0b0eda4ae1523c5"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "2e441d8385d5aef6a12ff77cfd2f175911e988a492d5631506139dec7be7ed39"
    sha256 cellar: :any,                 big_sur:       "bab958714fb74f92b6efedf3f9a0b028dcd1b425e5548f635057b18deb99fc45"
    sha256 cellar: :any,                 catalina:      "6c94cea0bc2913c0c0d800d6f6962661ec84272c2ff9070fd38f1e8a87b3f03a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "32649aff8903a3491ab6712a820d5c38f024dbba2771d6a1f3d1c8660c8a0c57"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
