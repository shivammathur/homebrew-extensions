# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.5.tar.gz"
  sha256 "369f1ee8705eb38cf20030a65d7017056e51a0f24fe06397740a76eed8f6a707"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "436cea17be45cd5f678f418743e5a94856b4e5935b8c96987e5677e22d4dc073"
    sha256 cellar: :any,                 big_sur:       "fdcb11874f39f6c4fcdc18f3f245f2c527eb3a7d7a54d00352239bab977c2280"
    sha256 cellar: :any,                 catalina:      "d630e831aca8edc31827cd50472f635731e2b1e06bb7b05d39875671332aa3b9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d6eba8d5fc1aa6361488072f66c699e37ee29c15ea85468600210294bb8bffca"
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
