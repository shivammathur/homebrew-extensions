# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.0.1.tar.gz"
  sha256 "8db635960f25b8b986f5214b44941f499d61d037867e11e27da108c19dc855c3"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "e5b53aa74319f9279c1c6248fa84e55d5f13a749313c6c7bbdc7ffd5695f2864"
    sha256 cellar: :any,                 arm64_big_sur:  "207f89342c66171ff515ff18b3a67ae19741a022b9ec597c2cfa8cf62037d311"
    sha256 cellar: :any,                 monterey:       "b13c46a4f75808a0f495a8ed96623c89540f2b432923624eaad420363c193ac6"
    sha256 cellar: :any,                 big_sur:        "fdecf4a2852b9328dcd2d577f73abfed102ae8961492218b25f6e70bd8d0a5cd"
    sha256 cellar: :any,                 catalina:       "870828e574621407bdf366737631795a0a39235b5a9c647714b46dd523c48920"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6072a60468ca16193b6dc8172a58c4dc70cad2e6bc9b112227a594529db87405"
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
