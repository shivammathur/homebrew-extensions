# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT71 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.5.10.tar.gz"
  sha256 "164d1a712a908e3186fe855afbfcbc9ff7bbb1e958552b6ad1cc36a32a72b3ab"
  revision 3
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "014a2c805f3a3dc0ac96cf81eedc36d6d4bc45c96fe2eb6b2d5ab525459b0a3b"
    sha256 cellar: :any, arm64_tahoe:       "f548ca1a2bb6e18dd429c08d130e32c2cf2cbe46e920acc19c6377c3f1105e13"
    sha256 cellar: :any, arm64_sequoia:     "ab20f111732e35a4f79ac63fedaec42e4088cbe94b69169ec6ee5cd267b67bd3"
    sha256 cellar: :any, arm64_linux:       "cb30cc17500ecccee4bf42508f99b281759d1d8383f138d2836bfa6b87aae52d"
    sha256 cellar: :any, x86_64_linux:      "2e213d6db7a8b4cc8ffd0fcad6e89f55b62d3a492fbb41cc151265c8b17b5288"
  end

  depends_on "brotli"
  depends_on "openssl@4"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    args = %W[
      --enable-http2
      --enable-mysqlnd
      --enable-openssl
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@4")}
      --enable-sockets
      --enable-swoole
      --enable-swoole-json
    ]
    inreplace "config.m4", 'SW_CPU="arm"', 'SW_CPU="arm64"' if OS.mac? && Hardware::CPU.arm?
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
