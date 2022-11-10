# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.0.1.tar.gz"
  sha256 "8db635960f25b8b986f5214b44941f499d61d037867e11e27da108c19dc855c3"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "3e36e3b6a3f1afa281124ea7ed00a3882774187a33ae79fa0e33c7c9f3a5181e"
    sha256 cellar: :any,                 arm64_big_sur:  "4179a97b8dc4db57947fd6fd545240bf0bac40919c77f4f4b83586a26040385f"
    sha256 cellar: :any,                 monterey:       "06ce5426804f39bd4b1eee968486734f5b5a474ff919e9ca7a79b1e0d220dec7"
    sha256 cellar: :any,                 big_sur:        "81b53ad8a3394da8bd523ba254adf032b4d4631c989ff7189a1e8915f2b0ea7b"
    sha256 cellar: :any,                 catalina:       "addc6244d2043a4574a434087e8557c2f2fcc321c4bbcb112c6aa593a6d340d2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b825ee6149fb615edf83ab6901c90461a6f098d37e7ca5992aae874a3de6aee7"
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
