# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhp81Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.3.tar.gz"
  sha256 "e93fee47c66cce13852d52e074a211d352f05f5c2644b280f653242d87c6159e"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any, arm64_big_sur: "b63bf2c63ffcd84bd8584e9af364f08d9dd0f732f04badd0c2cffe213c0eccd7"
    sha256 cellar: :any, big_sur:       "fc34c3db91d2fd753cc9273c31fd08aef02e45f3279be1eb25eec5bde6fc63f7"
    sha256 cellar: :any, catalina:      "5e624e176b64f602bd74f79edc65651d10a17934bd3f8dc5f0998995599d9bf0"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
