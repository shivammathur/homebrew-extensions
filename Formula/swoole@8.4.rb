# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.0.0-rc1.tar.gz"
  sha256 "b313a6d43699caeeba835071886b9f66093b2b181280e23073ee04840dacdcca"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "4872289f32b6bef13d797de6c6363f81cda2560486c71e8881e9d019a1a65501"
    sha256 cellar: :any,                 arm64_sonoma:  "3a20d924907e199761a935acd1b70a0267277a4e0bd3a2877c55ac7ee113477e"
    sha256 cellar: :any,                 arm64_ventura: "c7ae6ed3e32841c5e62eebe352d50b9fe6ebba0b1a46b17d20e77dea7e5400a5"
    sha256 cellar: :any,                 ventura:       "bf40bc72671316930603da6a4186a960920e6f6388e98dc8b7510f254110e777"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8c8d6a62876455744e398378d81e6885d1e52947231ac8c745ec9a7768a94fa3"
  end

  depends_on "brotli"
  depends_on "curl"
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
    ]
    inreplace "ext-src/php_swoole_private.h", "0, NULL, 0, ", ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
