# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.0.2.tar.gz"
  sha256 "b0bd47292add791b3bcebf347cd593c98a71c098dfeb96d125193bc95e95ed2f"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "a179e9a7ae34d1dd207b14c1975832deb188c8dbc83e1b8768c5d712012f2aae"
    sha256 cellar: :any,                 arm64_sonoma:  "92d9b3525e19cfc6d50fa2c69993142ac2095fef731df3363a5954211f6cfaf1"
    sha256 cellar: :any,                 arm64_ventura: "d1ce12658f6358ddc27722c1109e307abb2bb0c6ab86e492718d8c0ff39b1ba7"
    sha256 cellar: :any,                 ventura:       "8476893cfa92da2cfe5591b05ab948ad21e99b139dd2477c6c33dccffb560b0b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "03527c0bf8d95888270212c2d72a09dc1cb1a88df44bd97f021c91299bfccead"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4f321e2a0f00d8f7175f7ff6811e0169290b05623dc4c7fe95ed606fba82e68c"
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
