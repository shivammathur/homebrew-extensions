# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.4.tar.gz"
  sha256 "07845c2af6e25cbbf73b7e9aedbc5212e0be6cf93fec8274310ccb8b0ff41594"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "aba7f60232f358ff98a1991073ba66062b3d724e4318d1d5963e66354a22a3be"
    sha256 cellar: :any,                 big_sur:       "4275a10859720bc85e079c8201a875cce875a30da20feae7d98bbd13bb714634"
    sha256 cellar: :any,                 catalina:      "02aae2f8c986ee6bee92b64651af260b38a8b344edb980cd8da9dc44f9421573"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "50ab4ffba13c2179651314b97c5e9f6f0511689db463b7f97c68f4716fbecbee"
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
