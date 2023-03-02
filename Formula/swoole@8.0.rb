# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.13.tar.gz"
  sha256 "5d8352521ee31ddbd23b46eccffb5c99f03af99c6d058857ecaf964c2ef433d6"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "4f6a9c0cb68b2cee9ea37163276f50edcd76e34bb65f6e8c52bbfd0436c7f890"
    sha256 cellar: :any,                 arm64_big_sur:  "627144bfb0d3f2c37b8ba880c3242939fb7c3dc8e57fd68a7929757f633211ef"
    sha256 cellar: :any,                 monterey:       "2ec84a500bb36f51ed9577337f9d2da28cfd8c0e7e13def3c4b51402665afa4e"
    sha256 cellar: :any,                 big_sur:        "2a3cfe1d2e4d1950113a8a71fa3aeafe2b58ba153f806f79f5e43969a3ce0073"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5c704d7933fe85c6fda8aa7528c16bfa6615ac488d5165179dd1465b4853c69a"
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
