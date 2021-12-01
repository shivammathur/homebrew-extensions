# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.3.tar.gz"
  sha256 "aefea9b6e5dcb61fdf0462dc8a1b63deef4a1c73fdeff754eef81ab45f231230"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "7e1e14b18ae303ffb1473e567682ea7412157e79939bef626912ab1dc86e2110"
    sha256 cellar: :any,                 big_sur:       "701ffeac1b9d17128da03aa1854cfb83376a60359aab35aa0b47f40031f5353d"
    sha256 cellar: :any,                 catalina:      "3b6b739a1542ccaca6f8498468d531f4b6ccac4461eb4f3c6718f6f82e2b6327"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "86dc4fdeb0d2475f92f7e81f8b7812dc799eefcab97cf6da5e2c706168a255d5"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
