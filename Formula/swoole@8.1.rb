# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.1.tar.gz"
  sha256 "7501aa0d6dc9ef197dbfa79bff070e751560a15107c976872ec363fee328b0f4"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "f9163d8f94a80d2bfab161a561b0aecf20b5349b5123287c0916cc1ac6d6610c"
    sha256 cellar: :any,                 big_sur:       "8576c2f312987bdc25128d23689eb0293d57c6132ff3f98b3b485ef762375f55"
    sha256 cellar: :any,                 catalina:      "b5ebcbc3d0e3c93b5700bbd6f5c853c133511722ca01474efb3a0b6bed8e7e41"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1ee0567ab5d54c050aff5fa26e2a524f9ffce4b797039609317ecff78b2eda91"
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
