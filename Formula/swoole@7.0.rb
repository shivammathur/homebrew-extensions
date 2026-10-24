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
  revision 3
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "7d89834928ef614bea45f8588587053f72f9ab5daa632893a87201d4c7c47afa"
    sha256 cellar: :any, arm64_tahoe:       "332aeb54c415e0e3668e845266b985d4bf562efa0ebcf4be2dd2eb6115beffaf"
    sha256 cellar: :any, arm64_sequoia:     "821fe5f750820d6fcfaa41f7fd80448f34961a252db19369a41bc430e11f3ecb"
    sha256 cellar: :any, arm64_linux:       "a8eae880abe55ce02a4f1cca89ee526dc235ee46608cef72e4833465a85c80e3"
    sha256 cellar: :any, x86_64_linux:      "a15845604771f0421f6a666ff075f5ab93a7242417db995485fe31c7dad7b31f"
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
