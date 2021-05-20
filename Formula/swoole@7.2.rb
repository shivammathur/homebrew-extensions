# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.7.tar.gz"
  sha256 "f64bf733e03c2803ac4f08ff292963a2ec1b91b6ab029a24c1f9894b6c8aa28e"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "6bb06dc69fe3cea282bf503e3cc515cc1303b026a25162c5a881b6d766f3d8a9"
    sha256 cellar: :any, big_sur:       "01bf2c0c3abd931f0cc078c615267eb366be71b62bac2b81ecde2b0d1d478314"
    sha256 cellar: :any, catalina:      "7013e7f2ca745f5dbe9fd6c30af7bee361a475cfc794ad60f2d5e4314adf7557"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
