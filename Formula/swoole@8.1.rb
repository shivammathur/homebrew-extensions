# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.0.3.tar.gz"
  sha256 "c8d82949076aa42834681c738467d7448759ed8174d43a4ba40d8170d6f8da89"
  revision 1
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "bfc558f51a3716ede7713154bc06e46202f3e1cfa6b94a3933a982e9d02dfcc4"
    sha256 cellar: :any,                 arm64_monterey: "d6bedf445a635790cbf3013f2ff9ecbaef5c34f22e35041237f35590c2b6ca50"
    sha256 cellar: :any,                 arm64_big_sur:  "1cd65e0585855bf181a9a8978257fa87e1746d81b7639cdc3e04156fd2f8fb24"
    sha256 cellar: :any,                 ventura:        "bebddde074bd41651d9c73e64365534ac5767d3e4e511512a8af3fe224ab0008"
    sha256 cellar: :any,                 monterey:       "d265764af3d558a0551dc1af9ad3618cafdba6b6924f1304e027cd85de7722f0"
    sha256 cellar: :any,                 big_sur:        "9e23d332750d9443d7b62a7d54713ddca43475fad2e6cc14d217acd018843b84"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c82cacca9716a654ad99d7468e77a8e0dc29c85e09aac1ad6065400d9f8433ca"
  end

  depends_on "brotli"
  depends_on "openssl@3"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-openssl
      --enable-swoole
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
