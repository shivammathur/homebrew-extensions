# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.5.tar.gz"
  sha256 "369f1ee8705eb38cf20030a65d7017056e51a0f24fe06397740a76eed8f6a707"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "ee2dc24e6348da08fd39595f05ef576e864a90323acbf8ca94ddca18ec82438e"
    sha256 cellar: :any,                 big_sur:       "37667716d9528c2c66ac58c787ebc9cf37afe45f8b25ac44bf5bf3695bdbbdfb"
    sha256 cellar: :any,                 catalina:      "e01982a078528a94e888059895dd02b658e8038e73a07d8f10ff4235810560e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f4690e737af831344c09695bfcb93a6aa5af8cbb67d3ba9d5a1b8b94e2fd088c"
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
