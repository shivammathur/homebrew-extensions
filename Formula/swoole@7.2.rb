# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT72 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.11.tar.gz"
  sha256 "b81c682e4b865d6e3839b8b83640242f54127f669550111f5e99fae80ef1e142"
  revision 1
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "02b2bc546cf6c44663f0ee406aa93263668404f83777884196d910c4f27e2e80"
    sha256 cellar: :any,                 arm64_monterey: "0455fafaccde6203a7f11bbc70e852e3d9db14773019e2b8a129f463d9078209"
    sha256 cellar: :any,                 arm64_big_sur:  "3131d6cf37b471990820ba444ad4da276b9720645e827795efa74ee46ae83a21"
    sha256 cellar: :any,                 ventura:        "c33274dfa6fa9e67bb3543006689041ef967d5debcaaf5ecf80220e7e6602417"
    sha256 cellar: :any,                 monterey:       "d575c397ce1bb4eaf612296c93122de03c3e142400176c84ccccd79036b5df65"
    sha256 cellar: :any,                 big_sur:        "f489872032350320d623a116b67e5d454503df9dfb45d8f3ea467f4a111dd02c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "509ac42d962edfc00e46162417c5f38058a758e00181a4cabba7af194876e78a"
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
    inreplace "config.m4", "PHP_ADD_LIBRARY(atomic", ": #"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
