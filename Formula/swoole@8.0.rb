# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.0.3.tar.gz"
  sha256 "c8d82949076aa42834681c738467d7448759ed8174d43a4ba40d8170d6f8da89"
  revision 1
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "fdb512bad9268088b430bb1e21d257ff1d37d4cb7d1e926771db7a2566957d21"
    sha256 cellar: :any,                 arm64_big_sur:  "7a7530dddd6886f29924700705e89f08a99fb0db98e6741fecb652d2b0ffb37d"
    sha256 cellar: :any,                 ventura:        "45bbac7744d9d25f70aa633d8dfc597a89a298e440b4e87ef334f66eb5abc659"
    sha256 cellar: :any,                 monterey:       "faa0c7cded1422c4fc83f2cdf69b6e427b7eec1b20dbf74aa0d690d0c8d49938"
    sha256 cellar: :any,                 big_sur:        "c3581331e25d12a45e3b279a9a9a604b0d5f18680fc257866fdad9074d6575c6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d58589ca1dc3a9a2714eed113a1bbe33b1e14506aeaec28ff7d9d83dc84c81e3"
  end

  depends_on "brotli"
  depends_on "openssl@3"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-openssl
      --enable-swoole
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
      --with-brotli-dir=#{Formula["brotli"].opt_prefix}
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
