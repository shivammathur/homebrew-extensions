# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.9.tar.gz"
  sha256 "d859bd338959d4b0f56f1c5b3346b3dd96ff777df6a27c362b9da8a111b1f54d"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "5bfc01b7a3ca621516c6474e09f3608defe011e703214a62948e63db943bcfa7"
    sha256 cellar: :any,                 arm64_big_sur:  "f4a799481b7a3aa8a16351df5b45ec5a1e43c49f4f9ee35f44e0eeb8c612958a"
    sha256 cellar: :any,                 monterey:       "5c178ced69613cdfc99ea87f71ad3d353b6c2be42121d5a8deae331df7e2a8c9"
    sha256 cellar: :any,                 big_sur:        "5f5dc3b5f04a5107aa92f92d9f6ef20470ae978419d383ad19f651903abec715"
    sha256 cellar: :any,                 catalina:       "4001bc8cc50bb0e2314385052cfb3763c9ec610f417d3ad9c2a9b8db675e225a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "646de144d76119b8cef6ac7d6365e18cd35f0757a0a38d94dad772d228a05799"
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
