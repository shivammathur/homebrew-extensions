# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.4.tar.gz"
  sha256 "07845c2af6e25cbbf73b7e9aedbc5212e0be6cf93fec8274310ccb8b0ff41594"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "593f87a3688a175fe70c2ff313e96e66711269b24c36c871df79ea8391242394"
    sha256 cellar: :any,                 big_sur:       "e02ae58a0b456026031c6555796247dde0294936196bd27cbcf7e6e3b29e9112"
    sha256 cellar: :any,                 catalina:      "56a7f59528f143e204354753c951ea3a7390bb2ac108dec39f8fc04548bec4c6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1947a2321564d54b34b799281a139379be64640cbc357f49b3f5e8f83c76d190"
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
