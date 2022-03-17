# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.8.tar.gz"
  sha256 "36a942e894d83057404ef849e87ca344f31dda0d4277f99cef46023e2ba70c52"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "bd262dc2e77c747497a2a44d7405d0b90d0bd1121e451db0c7af404981c6aae0"
    sha256 cellar: :any,                 big_sur:       "c735b23f8161ec8b222f6cecf1f66442099b72cea9bbb316dd100b7da3a91d9c"
    sha256 cellar: :any,                 catalina:      "3cff5ea3f42375df4729471fc2d04fa036b8467f005e1d741b5fac3299c8af03"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "79f2d2ae1443afe193b7c05d2e41d0f09ee2924251ad295121323e714108904e"
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
