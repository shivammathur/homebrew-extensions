# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.6.5.tar.gz"
  sha256 "c93f6a0623b90ca6a6c96f481e6a817f2930b4a582ca0388575b51aa4fb91d38"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_big_sur: "03e9b9119f24d5b2708a88d901f6df7da6b91349036fdfa0dc14254474951833"
    sha256 cellar: :any, big_sur:       "4a917ef8d6422ae08ae2308e411e9e2a4820eea000fb3b1724d6046a6685037f"
    sha256 cellar: :any, catalina:      "fddb92cf6b34a4c80e4acbdcf062be1288549b69138ea98d6ed36145d2f75bcf"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
