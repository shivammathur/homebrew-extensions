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
  revision 2
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "e178e7ecb7fa09acad74a8604f6cdbc7bc51fbac850605a3d2695d106f50158f"
    sha256 cellar: :any, arm64_tahoe:       "543be0424cabeece1abb5f05b69637d93156158c948ffba93b48273020818131"
    sha256 cellar: :any, arm64_sequoia:     "af7899ddacd4ab9b9afc610efa5a99e3206aadfe31192e83eb3127ea64cd1418"
    sha256 cellar: :any, arm64_linux:       "9580d9ba9fad6accfa6197d8600aac70592c5084d38c321c4d192ffbf2b7e099"
    sha256 cellar: :any, x86_64_linux:      "63e5a037c04ca724f7b6f3292cacfb298b98aeb68c9d4f66d3a37285b4fb0f3b"
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
