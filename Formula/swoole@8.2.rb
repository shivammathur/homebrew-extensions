# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.0.tar.gz"
  sha256 "5a987a4e746f0909762f44fcf098fccb77f58f80aaead8efd0240402940a3110"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "ec044f7b38b37dbf99c581178c1918433bc03137140ae29630c8d33bb34c229a"
    sha256 cellar: :any,                 arm64_monterey: "fcb498b26ec441532aa816f84a44efcd9e4cf65b5e5523281a7a2d2217daae9a"
    sha256 cellar: :any,                 arm64_big_sur:  "e484afe4ba580853cd6d392b2828f1277a73df890e6ab6ab2738d372e5fcfc5d"
    sha256 cellar: :any,                 ventura:        "ab220586ab74ba3265daea0ce0c12f033d45c3fb8dbc2ffdc28388039e70e016"
    sha256 cellar: :any,                 monterey:       "b2a98a3b8af2b270f1b965dd6cd0b422704fbdda4d5831ceee96aff838083477"
    sha256 cellar: :any,                 big_sur:        "b072f7854ef62cc4cd67d888454e017a0cf7c88672f9b1a9aa6a91873dea07e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7d73114591e5b6a16d0174774495ecfa01f4e6d81d64c4cd30ebea41e64864f5"
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
