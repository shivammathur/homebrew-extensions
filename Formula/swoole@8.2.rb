# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.4.tar.gz"
  sha256 "753496d1832bea57126acd61bb7f9946a61604ee1d7e4ce7a48d1167c2801fe3"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "e4a5d9fcbdd887292ac5f0a72597c69acb3c5c42a6152aebf7753954dad3fdd9"
    sha256 cellar: :any,                 arm64_ventura:  "365f739dc0b584a4f6720762a4141ed0bd1c96b0f65d5dc6f6d2aa28c947414d"
    sha256 cellar: :any,                 arm64_monterey: "533397984e367e481447ed3db4a74812b0c23cc4d2bff074ce8f24f9b217c07c"
    sha256 cellar: :any,                 ventura:        "b7fe73616cb5adaba0e633c10490f11ca51f7b42e88a2159308cafd76404af53"
    sha256 cellar: :any,                 monterey:       "1cade96c1c47b49a21e4c8ed645d6637bbbb8d9d6be69b2e1cd729863c984aa3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "21a47064be81c2939c8e7a334ab007b34152fa395dbedf8f580d3c3577b9ebe0"
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
