# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.0.tar.gz"
  sha256 "5a987a4e746f0909762f44fcf098fccb77f58f80aaead8efd0240402940a3110"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "13ce56909dc1263bb9be304cbca169d318976561ba0246bf6f47b6713f9f25ee"
    sha256 cellar: :any,                 arm64_monterey: "02ca5072d4611668b42f1cb4091154a166809e7a6404b88ae59f2fb9a89316a8"
    sha256 cellar: :any,                 arm64_big_sur:  "3997343bef32c58929eaaf5baf8e85cdea23c4a20c17ed769f299f46e7e4f13e"
    sha256 cellar: :any,                 ventura:        "a2cf7254a48fa793ff1e05ba7bb5348522811ee9d9aa810e57b28a340cc40889"
    sha256 cellar: :any,                 monterey:       "85c72a4b62ef22e5bc2bd97d10415e2da984c61ba0167c0e60be26f53ab9d5e1"
    sha256 cellar: :any,                 big_sur:        "7a2a4cfb56149fa03311fe30e0996113582c59908cc7900a79995740215f2c02"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "98fd5981684b032e7c7151237bbbcfba671905e36da68e654da0d9d4c29af61e"
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
