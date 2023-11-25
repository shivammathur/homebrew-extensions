# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.0.tar.gz"
  sha256 "5a987a4e746f0909762f44fcf098fccb77f58f80aaead8efd0240402940a3110"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "39d7d4c6d78f1c34aadfed9d9a1c42bc3786b8f0a96cbab15a16c81f73cc5ac9"
    sha256 cellar: :any,                 arm64_ventura:  "8a3896db02ae1c5f1725606f361dd7ccbe5c61dccaa824cd31d82295e8ce1304"
    sha256 cellar: :any,                 arm64_monterey: "5828dafcb92f76a072a34b18b330df6655051bbb47f85dced49e15981d96c8c8"
    sha256 cellar: :any,                 ventura:        "6831a6c792a2954e62f95b7364455ca7bcab9d5f81ee22e62846a0611b89b1dc"
    sha256 cellar: :any,                 monterey:       "decc9de79d84b80b2f255a55786e11a95ab6f67cb921440909a6c7ae1ed2d373"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0eeef39093d5269f1653ffcf61c7c0d98f17d0ce4bdc2837f1a8f5428d916131"
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
    inreplace "ext-src/php_swoole_private.h", "0, NULL, 0, ", ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
