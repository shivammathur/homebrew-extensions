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
    sha256 cellar: :any,                 arm64_sonoma:   "e6c32b25d2dc81f89455dd2811fc9e61169e56e202b88243cf75023d5f4ad976"
    sha256 cellar: :any,                 arm64_ventura:  "a6a17beda4ff6a2cac59f3f712747f347d953fb165501165d91a2ebdb6995279"
    sha256 cellar: :any,                 arm64_monterey: "ac323a30b0f9da8f74493ba3737f84ef3d1eeff45ce96fefb19f54dfa72eff1c"
    sha256 cellar: :any,                 ventura:        "7c07b07c4a18a436c66ab384773aa310c64d42d108863a4f30140d179e030e97"
    sha256 cellar: :any,                 monterey:       "5cc5c87e8909b58d6ba5c07d1577ed4065f7db916944a98ce874db883acec974"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0e29f424ab362fe17621a558f16f4b5eab87eb82580121b00adf941e6dffef94"
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
