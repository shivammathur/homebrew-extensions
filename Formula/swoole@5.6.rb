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
  revision 3
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "c5e4c206bc0a40dd0f48764db9760ec7e1a0e4243c3f36b08c27d6b89e994249"
    sha256 cellar: :any, arm64_tahoe:       "36be9c84a035e2bb506cb41761a1aae98cf0bc92c7215d31bd029b82f083c469"
    sha256 cellar: :any, arm64_sequoia:     "de8231e952695f3f46f5fe279c74a2a4365dc2659224d726a967bc302dcd6027"
    sha256 cellar: :any, arm64_linux:       "04b3a4838b9de746977581d1804b796d179dfb3fbda69119328c91f4e74d818e"
    sha256 cellar: :any, x86_64_linux:      "1250e7e6f483b747853775668a3b72582b1135c2efdc2e891b4ff908ae612f38"
  end

  depends_on "brotli"
  depends_on "libnghttp2"
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
    ]
    inreplace "src/protocol/SSL.c", "#ifndef OPENSSL_NO_SSL3_METHOD",
              "#if !defined(OPENSSL_NO_SSL3_METHOD) && OPENSSL_VERSION_NUMBER < 0x40000000L"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
