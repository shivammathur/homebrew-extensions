# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.0.tar.gz"
  sha256 "5a987a4e746f0909762f44fcf098fccb77f58f80aaead8efd0240402940a3110"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "622c7834d83181e08776193f155f2c2c2ce093d65d42609aa60799dd61b44874"
    sha256 cellar: :any,                 arm64_ventura:  "e5954c5da1b57e2d87b5a2f84035c32d347149aba7e98bfbebf483c298b88743"
    sha256 cellar: :any,                 arm64_monterey: "33e4e4d4fccac67a92217f58acd1620f08c77c6e1b16ac7425c001ca70a0927a"
    sha256 cellar: :any,                 ventura:        "33a6b28cdde4b7bb7285665f0f3c534e4bea9cdd4ec377b23695ad8be250f166"
    sha256 cellar: :any,                 monterey:       "f89b8d374802c60286727c4360d57ada30be50993fc5ee23a38a85c0bcade68e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bd491efab9554d5724f3fd6d6c1b86c570a99f5d508b2a57a0d666565456d06c"
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
