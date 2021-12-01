# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT73 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.3.tar.gz"
  sha256 "aefea9b6e5dcb61fdf0462dc8a1b63deef4a1c73fdeff754eef81ab45f231230"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "368969a87e0ec370462b8fa907e0cda1956b6e1e31ff94131e941deed2b6e6d3"
    sha256 cellar: :any,                 big_sur:       "3da8461ce3b8fdfe516c2ffeec3fccb941fa8beb741814061c013fd4bf0f7c7d"
    sha256 cellar: :any,                 catalina:      "5225d7e0721bbdbf832f3ad4dc54f2570815684f1f47d457fcf3c5c9ceb20a7a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7d321dd8a0aca4876695d00a307c39ae610453420d155f8db0178a38bcfc2461"
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
