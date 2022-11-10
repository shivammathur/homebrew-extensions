# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.0.1.tar.gz"
  sha256 "8db635960f25b8b986f5214b44941f499d61d037867e11e27da108c19dc855c3"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "ecc6470e9b4889141efb1342c6f6de451bdac2cf58b4147749af8ab9ce8ca779"
    sha256 cellar: :any,                 arm64_big_sur:  "121b5e21279cdfc732d0842a1638f0d8b0228cffbd2f09b37c746e884307f956"
    sha256 cellar: :any,                 monterey:       "789c5b802e09e611dab441b0bf467b14dc63a3d1ccb73c616fca83a3b7e00c5f"
    sha256 cellar: :any,                 big_sur:        "1256b6175bacd7f11a4200810a19e75039aa0d9430e598829de77c887434f66b"
    sha256 cellar: :any,                 catalina:       "934386eaaf45d678ce2f4bf6b550a2bb74d236120ba3c03bf380b9089ffae777"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b95ec94bcc13607b66fad58f4551e6cb595c4c1853eb92c622066152703d2429"
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
