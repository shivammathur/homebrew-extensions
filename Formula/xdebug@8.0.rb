# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/swoole/swoole-src/archive/v3.0.0.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "ee454b74a32ff48cb235a2e9c25e42cdc658dbfa94df6bca03e3fc9435abc8fb"
    sha256 arm64_big_sur:  "9b37f023c3bab79b216d41b3c91941155c1a72921dd7a27fac0b6865cc554497"
    sha256 monterey:       "0d9892f1e56845ba0c93578e7b6509303e48d0758dc52e738e29f8fec9c43f33"
    sha256 big_sur:        "d644dff9f7abf08d0fff1813453328491feadd4c9a3311adf71a6dc28ad428ff"
    sha256 x86_64_linux:   "770e9b99b0ebb708bbae0648f4fefec84cbf3a37cfec36801767da422fd9ef4a"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
