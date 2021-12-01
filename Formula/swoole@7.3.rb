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
    sha256 cellar: :any,                 arm64_big_sur: "9c7551494f9c0ea622553ef17cafaac6c807ad093585d55a2921f5c840d86f49"
    sha256 cellar: :any,                 big_sur:       "7e27eaf29d36fb774587dc8d23dc609958872d57d635749522cea834999e8272"
    sha256 cellar: :any,                 catalina:      "2ff2259985b5f9ea8caaf36064955a227b1106fd9e7774ad5f0c7e34d42f44ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "86a95e9bde02fd147772d5d4cce51b2ca222bb1642c032755c08d3f7f02a553f"
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
