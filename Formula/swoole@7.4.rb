# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhp74Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.3.tar.gz"
  sha256 "e93fee47c66cce13852d52e074a211d352f05f5c2644b280f653242d87c6159e"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "f227e52ad460e1ddad7386ea671884f9740a1d994fdb3ef9377917b0cc084fc2"
    sha256 cellar: :any, big_sur:       "ecc5003a75ca6fbb5e97f6ee796c2e802dc295a59d31886228a92110ee7e1020"
    sha256 cellar: :any, catalina:      "aca262a55f625baa3eb8299c995e2fca0fbb7a23e733c346e6f0c330eb06d35e"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
