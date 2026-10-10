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
  revision 2
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "278c79f15e8b65cbbcf5633ba813790ae660826ea61010ebe8aba0460cec358c"
    sha256 cellar: :any, arm64_tahoe:       "dc9f701d28024a794901b244042175a76f78ac541dded3dfbc14d343267c606c"
    sha256 cellar: :any, arm64_sequoia:     "c99d2b07ecf09b37daed1fcc78d7ac5dbbf34088db83d71349801cc406ab0192"
    sha256 cellar: :any, arm64_linux:       "9a79b7f1568f2f21a13dd0cf040410f575c99f5a31da5c517263fbd6d4740531"
    sha256 cellar: :any, x86_64_linux:      "7c6fd0c98adc4cd6dbd193f01e3211d20d7f3a157900e9869d2d74b4248ad6ed"
  end

  depends_on "brotli"
  depends_on "libpq"
  depends_on "openssl@4"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    args = %W[
      --enable-http2
      --enable-mysqlnd
      --enable-openssl
      --with-libpq-dir==#{Utils::Path.formula_opt_prefix("libpq")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@4")}
      --enable-sockets
      --enable-swoole
      --enable-swoole-json
    ]
    inreplace "config.m4", 'SW_CPU="arm"', 'SW_CPU="arm64"' if OS.mac? && Hardware::CPU.arm?
    inreplace "src/protocol/ssl.c", "#ifndef OPENSSL_NO_SSL3_METHOD",
              "#if !defined(OPENSSL_NO_SSL3_METHOD) && OPENSSL_VERSION_NUMBER < 0x40000000L"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
