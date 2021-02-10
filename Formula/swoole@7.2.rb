# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhp72Extension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.3.tar.gz"
  sha256 "e93fee47c66cce13852d52e074a211d352f05f5c2644b280f653242d87c6159e"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any
    sha256 "0197020e0a782fb87df5534b8870a8a2b2e960fede682c090f12c7f1f75830ea" => :big_sur
    sha256 "b99a7ec4c7b42b70cad4084af5c944b040d2bfdd33943e71a08786c38c91a280" => :arm64_big_sur
    sha256 "d2fac23f80095015d90ea30124e3495abe6b93b495d642d39bb69d04c1bdefce" => :catalina
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
