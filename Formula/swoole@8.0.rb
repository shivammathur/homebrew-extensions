# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.1.tar.gz"
  sha256 "7c4ad3d65a5221aacf2428d7062be922ca0090a3bc9000f8bcf4cd98d011ad8f"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "b2da696dad864d019847ed70e73f5aec331855e2c4ef48507fc96928779ad278"
    sha256 cellar: :any,                 arm64_ventura:  "4aa82bb6693dd3a10d363cfec22b906f21c6a90a82f0c3fc4ce59fde5f9afb8c"
    sha256 cellar: :any,                 arm64_monterey: "0fab090d35fe21bd68037f7864f5706afe69f0fadd9f9607d454cf8afddca361"
    sha256 cellar: :any,                 ventura:        "b4868c5b8c18816e4f1ffc88fbe059711e8c2ad060aeb5c2e34e6b2bb44f08f6"
    sha256 cellar: :any,                 monterey:       "cba171e7330ae561504c6e27bfe84e9e42db18a9ff645db585160c8f659502cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0ab1be59f7a107949fc6e6f25a17928096725a3c0c9f1b796bd3d4fd670d5a1c"
  end

  depends_on "brotli"
  depends_on "openssl@3"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-openssl
      --enable-swoole
      --enable-swoole-curl
      --enable-http2
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
