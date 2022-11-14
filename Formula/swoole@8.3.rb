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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "abd6ab4c1a1506460c3f46298fd3e3839bd8678e2b0d0fbae1a0340894ae7637"
    sha256 cellar: :any,                 arm64_big_sur:  "23d15201906a6677f1b9ce4fac759abaaec9017e51cfba10c2573f73301c6aea"
    sha256 cellar: :any,                 monterey:       "bb2da6b145039d078423825d6f44007012a835ce51292577ff61aa9a014f66d0"
    sha256 cellar: :any,                 big_sur:        "d3ddb59c6974d7f093fafdc1c911b6ddcb65a5042cd0238860524d209b472032"
    sha256 cellar: :any,                 catalina:       "b12eb41e39e6ad5e6b14f8d92c37d9d9ae41d633f346e9600ba7bcf5d84faa00"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6e490cfb5f6e8ceb9b2897c0a6a56546b5df340bf92ae4d7f460804f4380fc4a"
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
