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
    sha256 cellar: :any,                 arm64_big_sur: "928ff58f5384feb17466ceda6222dcdb95b6f79a28e2e1d57984bd1bcf3aba87"
    sha256 cellar: :any,                 big_sur:       "e7619ca101518945f2b3c6d81d3250f653d1b7bb008cba2a4de58bb1ae18c37e"
    sha256 cellar: :any,                 catalina:      "6f5708bba1d645dd9eac1a51ba6660fe9c884498136768c90e65a3afbabdde9c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4e1ee38e6f4f91e4dfa4dc2150b7e45258b9d01385ce01a930a6847689dcccbd"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
