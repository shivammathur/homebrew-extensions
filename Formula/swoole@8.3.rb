# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.5.tar.gz"
  sha256 "36e6581c11f2bf277ac192d0521c719a6f234b91e5aceffe9e9eae9f3c39ac17"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "4754826f7c0cc174363bd4c25c97e076aef331678b440db56105e78e9a02a839"
    sha256 cellar: :any,                 arm64_sequoia: "12e96e8cccf0f5373da77bb8141515845b0b7fa9927edf21a647f47d1e0c1fb6"
    sha256 cellar: :any,                 arm64_sonoma:  "6c696e7649169799d3d970c420bbe345017cb8b2df87a01c273b31cd55c55531"
    sha256 cellar: :any,                 sonoma:        "977faf2413547ac32ce16616896900a3ecf7dc35d0f9fd20cfc00aa6de8cd034"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7291e34ed7371845685e0766117282cc263b8e5575d6f8447fd781882275fb5d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2776b8b95b092759e9150ef6fa7505add447928ed9a7657d863bad12d6bc8fa6"
  end

  depends_on "brotli"
  depends_on "curl"
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
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
