# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.0.2.tar.gz"
  sha256 "14d442d5e945fe67a3e912d332175b2386a50c38a674c4559d2d0211db23362e"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "8527f71840bca8a06ae9b5bd0e0d831190706c207f32a1a5bbd7ed6cb4111493"
    sha256 cellar: :any,                 arm64_big_sur:  "af0464ab11a6b6bc937cc002f61e21902d34ec0888454c5c489b7ed2df61986b"
    sha256 cellar: :any,                 monterey:       "f7888fba167cd8a8a6f2470cba4f0e9e86fe529854158865c9333863ba156319"
    sha256 cellar: :any,                 big_sur:        "9391bc750858a63f76977bf1ee25b33ddd75e0eee83cb9115f07d07d85a257ae"
    sha256 cellar: :any,                 catalina:       "0054ca0ecec99e98a0a20fdb75e0f43005100946db86f4a431dd8b87da47da36"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cafacdbb19fa76ed215126de3b494f2f38782c451cbe81c967a6627cff6c8ea6"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
