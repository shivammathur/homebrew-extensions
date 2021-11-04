# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.1.tar.gz"
  sha256 "7501aa0d6dc9ef197dbfa79bff070e751560a15107c976872ec363fee328b0f4"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "e273e6a37e8b100c74060bd1abcb7b6c26d9435d429a6921d270ab00b1089999"
    sha256 cellar: :any,                 big_sur:       "17674c29867ae0ab41f202e6a69fe381f0ae9d913f4c67de66d794f886432e1d"
    sha256 cellar: :any,                 catalina:      "96f63b53d50c733f656e81453b0a11e62ed8f99845ae6cbec86bf2c82b08c2ee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4a23c62a2429011c6fa207698f1b387140188000ba511ba55860d05355a10008"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
