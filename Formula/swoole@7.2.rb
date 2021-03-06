# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.7.0.tar.gz"
  sha256 "a1d052079c370405f19bafb346e976a8b0e9a0a90c859af9cf752d4ef1025981"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "928ff58f5384feb17466ceda6222dcdb95b6f79a28e2e1d57984bd1bcf3aba87"
    sha256 cellar: :any, big_sur:       "e7619ca101518945f2b3c6d81d3250f653d1b7bb008cba2a4de58bb1ae18c37e"
    sha256 cellar: :any, catalina:      "6f5708bba1d645dd9eac1a51ba6660fe9c884498136768c90e65a3afbabdde9c"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
