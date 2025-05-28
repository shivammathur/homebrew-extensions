# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.11.tar.gz"
  sha256 "b81c682e4b865d6e3839b8b83640242f54127f669550111f5e99fae80ef1e142"
  revision 1
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "4dde7267f3582ac59bd628b187bb3a9fa0f61c8db265c7e17e7eccc040a76308"
    sha256 cellar: :any,                 arm64_sonoma:   "49d88338b65aaadecaeb450ecc7144b8fcf5c01f3e518a0121d054ee71f81c58"
    sha256 cellar: :any,                 arm64_ventura:  "cd6993d7d3eb7ea619e8d673b792c4abdf33d462f3936d7d4420bedd7fa966e4"
    sha256 cellar: :any,                 arm64_monterey: "df0e50ae6f944f05b4a8f3b77ea693fb8e35c79fef3f705dab8cadd0c236230b"
    sha256 cellar: :any,                 ventura:        "4d15c4667e82b5c01b67741b31f6e38163bcf55a2372223c274e55e9d8425ad2"
    sha256 cellar: :any,                 monterey:       "743a3f30d52eb1e8671d280b6423ac15de33c9cf2017c0b19cd87f6ef96b22e3"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "23e465ecfe01addfe7fb56e6bf303f1d8705df96f9f6fdc60df1645506011999"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3d6ddaf96a0f09db3feae2dd942b59ee2f87ce74e31c5d127af5fed2f28c21b4"
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
    inreplace "config.m4", "PHP_ADD_LIBRARY(atomic", ": #"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
