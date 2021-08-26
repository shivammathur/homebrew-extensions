# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.7.1.tar.gz"
  sha256 "0fc700c8ea65ecf5247c7394a49b1f211e4a419987dd50adc0b0eda4ae1523c5"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "b2dc5ee026121b2c5617f02a9330edabd863d61ecb99260da8adf5fb11fd17dd"
    sha256 cellar: :any,                 big_sur:       "b43c1317d778c26a7440d534bdf60e5efde31bf4debd695057f66eecd632f6c9"
    sha256 cellar: :any,                 catalina:      "9ba696a6e86c33bba5b65b20593b0b2383d40e2fae8089b75f4443b67e62e737"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5d85c61a0d42529e5073f0f9a8c8ddc03d94374438bacdabb6e13ceef9d8f016"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
