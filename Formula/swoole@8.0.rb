# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.9.tar.gz"
  sha256 "d859bd338959d4b0f56f1c5b3346b3dd96ff777df6a27c362b9da8a111b1f54d"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "c5e0e6ddf6a5a65338ca421d61cb5f19fecdde38ff486516884600f2c75dd5fe"
    sha256 cellar: :any,                 big_sur:       "734df4987c130699de5793a30530521fa0c93ba6170f9f533b833ec891bd9908"
    sha256 cellar: :any,                 catalina:      "c1a508718da1ab7f604d9b6df4520ddeb3a4a322372d9244b17e7db0c40ba343"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ab3f363d0403c03addc1cf63292203071e8ed4502ef7f7015bd1dcbfb956d781"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
