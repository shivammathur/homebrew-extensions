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
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "be27966eefcb41bfed4088db96d1a00af3f0b22996bc8ce9e2f4a9f570ef60cc"
    sha256 cellar: :any,                 arm64_ventura:  "10bf5bfb0757a9cdc62b742d9f91200b8fe80bec1a3e2430ea29cc3a7f0a0af5"
    sha256 cellar: :any,                 arm64_monterey: "c2a9260918ecab10d88d4bb5f5f7e4155ae0643dc74c72f3eee1cb3f77128211"
    sha256 cellar: :any,                 ventura:        "edb3b8d9b26bc043e4ac4f10c006b529924400d1c14863132dffafe0fb8afa55"
    sha256 cellar: :any,                 monterey:       "970763271a9950a2d0583460bd5dff92a31097d5c0d44a38662fc2aa32b0a43e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2c560399d848ce37fe9b6a9ed80b6df938ad8ec802ac00d1e9f25663fec6f1a3"
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
