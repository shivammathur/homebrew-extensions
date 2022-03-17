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
    sha256 cellar: :any,                 arm64_big_sur: "9ffcd9bd3de5d9023bcfac5eb2ff38e68a4fc39cd13e2659200860722893b601"
    sha256 cellar: :any,                 big_sur:       "48514ab2ecc07f61044ec38d285ed8ef494ca37a549a144e5de6e7134d790359"
    sha256 cellar: :any,                 catalina:      "a4e3c65bb09376864b34e2257494bb673c180b16e98fd9f56ffebdd7f7006bff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a78b6700fc528ecca7eeefd73a985a2eac9dc1096f6ce0b65b2d35ba0623f6ce"
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
