# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT56 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v2.0.10-stable.tar.gz"
  sha256 "ea1c8cfdef0e43f2b34460f88f4aaa5c1ca5408126008d332ae4316e1c9549ff"
  revision 1
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "65491ce0883d49f8d366c841ae69da35b22d4d0ce4498fc8bb97dae64478f0d1"
    sha256 cellar: :any,                 arm64_sequoia: "c40a0bf24e28dce48b0620cabb9dd9a527e161f668c622f87cfe53e7aa988e1b"
    sha256 cellar: :any,                 arm64_sonoma:  "8b8a0da16d3f9cb099e7a6951eb375751ee31330e6fde88b573ff76e954895b5"
    sha256 cellar: :any,                 sonoma:        "4b381a57f0e107e24db75302deee53797062e681fbad9d64be78d4ec0242a201"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e2c8bd4a64e4b724dec9c83f83d3c4594ea738f8618302d25aade87e9aba430e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "18a091b7e17eba28ae73665b133b51f6e27c92bdeaaf7b7fb21874f082dcbc28"
  end

  depends_on "brotli"
  depends_on "libnghttp2"
  depends_on "openssl@3"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    args = %W[
      --enable-http2
      --enable-mysqlnd
      --enable-openssl
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
      --enable-sockets
      --enable-swoole
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
