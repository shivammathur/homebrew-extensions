# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.0.1.tar.gz"
  sha256 "c1e35bbb4714e44d3c180a292ae2b55cf94de8d8f2a3b197d1e844f866a0e5fb"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "9ac7c554e18392d19109ce9bf66d793a91b07468625b9e1a3c75f0cdd4d3313c"
    sha256 cellar: :any,                 arm64_sonoma:  "047e0235d74eddd0e6292406b7b77a856a30daeb69e0c0fd58c1864d27fc8097"
    sha256 cellar: :any,                 arm64_ventura: "64bb209eb064fbd9f31ed356dfcc6571bd17ce2ae1e01e1f6f41bcee1b80bbf0"
    sha256 cellar: :any,                 ventura:       "b7df4590a9854929204271c11596ca17c37956f99eac06b53d694cdef816cb21"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a820548c20bec96fb31b4f7bcb8b8bbb6f5a12cf2cf43f91b7ca1e00fdd0b213"
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
