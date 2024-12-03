# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.6.tar.gz"
  sha256 "0df87a2257f800607d38b6c703789facae5e1d9a9e78cd4a52c3fdc9b6fb64eb"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "8f3cf4d184858667d6ba2e708f0a0172d1b56c8f3e182c6350e0cfdf0b801af4"
    sha256 cellar: :any,                 arm64_sonoma:   "4283a1aa351e03b37f7fbc3afdd7e9d01e8a0a2b13b426298af7d97888ce55c5"
    sha256 cellar: :any,                 arm64_ventura:  "ef3fc3a7195f0b38ad476cb58081cd903b0193f1d47ead4dc2dd3cb8afb5198b"
    sha256 cellar: :any,                 arm64_monterey: "c47aefafce5cfc17686c665b51b2abceb10dea37bfe6d45efb23d691ac892edd"
    sha256 cellar: :any,                 ventura:        "994383fbce975e37df8a973626e0d75506410bd702876712d99fc016ff09c0c6"
    sha256 cellar: :any,                 monterey:       "deafd36dc56ab68a370ffdc5eb32bb7fc4c55513322e8388d2421cd795c63cdf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "66a862c4119cb9173279854b5b6c4acfa74eaad24ab55d4a95981cdedb1d60f0"
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
