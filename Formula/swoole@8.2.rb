# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.0.tar.gz"
  sha256 "5a987a4e746f0909762f44fcf098fccb77f58f80aaead8efd0240402940a3110"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "27e84f05d9c14b9e51f66007d4bf8b259a172bd32058b16fedf4e6f2982505ef"
    sha256 cellar: :any,                 arm64_ventura:  "53295577e4eaba715c7f4a66bae97e74bfcafd7f3c8e35a2eb11e4142000c080"
    sha256 cellar: :any,                 arm64_monterey: "5e73be944d367d483344cbf9307439ad6e5f50612e1fea5a8180fc6acf638b50"
    sha256 cellar: :any,                 ventura:        "7ef77bf8e98a6b290a00e3e083e5937e74de6f4e87ff8484d56208e63dd2512b"
    sha256 cellar: :any,                 monterey:       "885439e35a7a1c515883d93538d3212f636db908a9213dca69536850c2a0a210"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dce6fe31b8a2ad7c7b6e738eaf23c40afff9b50242d4ebd6d52096e09fa8d180"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
