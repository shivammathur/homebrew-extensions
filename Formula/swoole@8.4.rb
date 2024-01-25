# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.2.tar.gz"
  sha256 "89d88ef2f7dfca96d4ff74febc62ec78ccbf92996176107cf30d538b30dee1ba"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "fae736e806c5dd013427bee7abf87c9571716c31b69826ca71561bb07084ffe6"
    sha256 cellar: :any,                 arm64_ventura:  "c6292d13b54f9e25c87bd772563e475a87277b85c5f6050ca1264e5917ecf47b"
    sha256 cellar: :any,                 arm64_monterey: "9b83296fd5b8c2dd292a6b1cd75de7b749f3a04c7a6329207d45c445f3bf5537"
    sha256 cellar: :any,                 ventura:        "e028e5d0fcfa2dd4098208b948d1ea0a8997e2d124013813ebc2416f31f4a230"
    sha256 cellar: :any,                 monterey:       "644de87c05fb305a53c396b30c30050be2ebf43eb314e7c19837daf2b73f0daa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "39b996467fd9f249d9cb50bbcca7d394aab05436107e0dfa4588c5832fdd89c7"
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
    inreplace "ext-src/php_swoole_private.h", "0, NULL, 0, ", ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
