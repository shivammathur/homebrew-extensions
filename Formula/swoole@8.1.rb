# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.0.tar.gz"
  sha256 "5a987a4e746f0909762f44fcf098fccb77f58f80aaead8efd0240402940a3110"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "e0a9172431c8294ff73dd6ec427a75b5b6048fcd6b689616499315efc59d91ac"
    sha256 cellar: :any,                 arm64_ventura:  "c7673b08d5a4af69cdb6d6a73ddc6564f8dbabc878b0bb7a94112cfeaace8441"
    sha256 cellar: :any,                 arm64_monterey: "739018b92d5403b63f7052689530e03a088384ce6b81f39423256d6bd69d9813"
    sha256 cellar: :any,                 ventura:        "b56647700eb4b7aeca8471dfb27cb00f37b8813488e2597c9da2cbd25870c544"
    sha256 cellar: :any,                 monterey:       "094121e977f7ef5301b8cb8d11c4869be6298a3258b408b0da11f87e2f2d9d9a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0d3cb72fdcdde5d3cd57b4c321371dae120fdd9b9f1ab4cac6a19ebaf4711f70"
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
