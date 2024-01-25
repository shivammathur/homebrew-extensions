# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.2.tar.gz"
  sha256 "89d88ef2f7dfca96d4ff74febc62ec78ccbf92996176107cf30d538b30dee1ba"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "65b46cd355f67d2276eedee93225a0ccba4ea0935a2578b764372bfa5a264afd"
    sha256 cellar: :any,                 arm64_ventura:  "8d584f095febb2899fcfeaa0f1160a8c5b4b86c4fcac4cded7120207006b255c"
    sha256 cellar: :any,                 arm64_monterey: "fbd6ea05e67004c5054f7e23d2603c051b292c67caea5cc2824f4cffd5556b7a"
    sha256 cellar: :any,                 ventura:        "c3f0165c76725ffb82b1e9d1a1550467605d1e9643dea625a5644058073d5fb3"
    sha256 cellar: :any,                 monterey:       "debb90d89f7e4109c1bc975661183e86870ee15ffaafea19d402ebcccd8d9ce3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6327618fc1e9a834b13b76f36b0ee58c12cd9e9c7e22feccca337e9d9a92c513"
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
