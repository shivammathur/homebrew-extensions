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
  revision 2
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "1b90d0b2398796215645896a915df5ca16fbe5b793f39bc5e31ecaf6982ac43a"
    sha256 cellar: :any, arm64_tahoe:       "aeece8992a17e7160d612f3bdcdc3b65a13f0394542c222343fa09c796908c2d"
    sha256 cellar: :any, arm64_sequoia:     "14d2fc1ca52e65b133653e33f4558d48dc553db5f9a8cf63b8a7795b1254e593"
    sha256 cellar: :any, arm64_linux:       "a7a4aa45192626f24a5935e2a38d3aafeb1cfb791e9adaa2304ed437847fb61c"
    sha256 cellar: :any, x86_64_linux:      "8f3e56bf7851cf44b95145ad048402d3815e80d93b0b7751b7bf1abd7ca15ca9"
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
