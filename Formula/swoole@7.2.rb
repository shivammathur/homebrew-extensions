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
    sha256 cellar: :any,                 arm64_big_sur: "7f2e515c00dc3a2effff12c03714d8af0542dc14392901ddbdafbc834c10f677"
    sha256 cellar: :any,                 big_sur:       "563301ba72e6fbe04a703aa0c5bb02f1d9a106a919b42ebe2791316e6ac5acd9"
    sha256 cellar: :any,                 catalina:      "4e410ac5e6f06e37e960ef6937778d216491eeae38f18c5478af2b41a86edb5a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "450c52d92ddadd11c22794aebd228f840bd2c2b34a0ce4729cb95a34cb38dd56"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
