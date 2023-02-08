# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.0.2.tar.gz"
  sha256 "14d442d5e945fe67a3e912d332175b2386a50c38a674c4559d2d0211db23362e"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "318afb262bb621eb0b6338fcb59197a5157c11657cf76adcfa0b91250ffd58ab"
    sha256 cellar: :any,                 arm64_big_sur:  "4265e24e805417080676d4b96ca152cfc7228872a1758821bb4b92a855b9a030"
    sha256 cellar: :any,                 monterey:       "1cdff2f3f545111d62dda7b443c172b14fe20ba2c6f3f04f103067472562549b"
    sha256 cellar: :any,                 big_sur:        "c6d163d3d094d0da2acfa26f8cbcf90b95bfb69acd9c5d903daa34a7d11a5252"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "45717ea1c2cd0a8f72c5520e16f079fb061326756c0beec2e3e196bdb092d94c"
  end

  depends_on "brotli"
  depends_on "openssl@1.1"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-openssl
      --enable-swoole
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
      --with-brotli-dir=#{Formula["brotli"].opt_prefix}
    ]
    inreplace "ext-src/php_swoole_private.h", "0, NULL, 0, ", ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
