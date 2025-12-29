# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT70 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.3.5.tar.gz"
  sha256 "fad1f7129e54ffae8fce34c75912953f3afdea40945e2b4bf925be163faf7cfc"
  revision 1
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 sonoma:       "a0f40c7543938dceee686cfb26d12521be7d362dec0551e2404ca76fdc55601e"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "f7d451b605b1773f68a820488619a0a2253d2f4a9bcf239632a9d546ef0caad6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9b5235759e3e4b56dcdb5e940830f0d858c1b83d635533f2c17d4c05746ab5d0"
  end

  depends_on "brotli"
  depends_on "libpq"
  depends_on "openssl@3"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-http2
      --enable-mysqlnd
      --enable-openssl
      --with-libpq-dir==#{Formula["libpq"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
      --enable-sockets
      --enable-swoole
      --enable-swoole-json
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
