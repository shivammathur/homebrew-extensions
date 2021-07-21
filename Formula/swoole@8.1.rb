# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.7.0.tar.gz"
  sha256 "a1d052079c370405f19bafb346e976a8b0e9a0a90c859af9cf752d4ef1025981"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
  end

  def install
    patch_spl_symbols
    inreplace "ext-src/php_swoole_library.h", "Serializable, ", ""
    files = Dir["**/*.cc"].select { |f| File.file?(f) && File.read(f).scrub.include?("SW_SET_CLASS_SERIALIZABLE") }
    inreplace files, "SW_SET_CLASS_SERIALIZABLE", "//SW_SET_CLASS_SERIALIZABLE" unless files.empty?
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
