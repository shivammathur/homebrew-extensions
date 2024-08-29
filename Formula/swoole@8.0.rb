# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.4.tar.gz"
  sha256 "753496d1832bea57126acd61bb7f9946a61604ee1d7e4ce7a48d1167c2801fe3"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "e7f45586fd186a59584f2aee768636603a42769a113a7adccaeddbe1df752653"
    sha256 cellar: :any,                 arm64_ventura:  "90d5ef85566abdb136d4ac8f0201f9c350a97babe72480fee37cced006b746e0"
    sha256 cellar: :any,                 arm64_monterey: "a534923398f640fa65c098835a44f2160cec210543c448602a6559c738574f7c"
    sha256 cellar: :any,                 ventura:        "1bae43e61aa5afe7f78443d0940eccdec904397d18554253af1c741515a7f152"
    sha256 cellar: :any,                 monterey:       "0d18d93bb01c760b0a329934dbfbec1404607c18ea5547e841f4b61180ca8504"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d17d6f86e8d757312b29024f1e61d02e124b965061ade6c85540fb534e74f207"
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
