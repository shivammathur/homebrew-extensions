# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.3.tar.gz"
  sha256 "dc7a24094fe86025de4a0fed2a94005d2266a29332e7e9e6be50238a8ef6cafb"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sonoma:   "569b100db4f8e25c318e128149cd7913c78c7c1e2fa343bffa632981b557e0cd"
    sha256 cellar: :any,                 arm64_ventura:  "9680b414a5caa694952df204541493a35936a3ce71cb0f83e54eec2620bf0b5b"
    sha256 cellar: :any,                 arm64_monterey: "3da656f67489c0312bf72fde293bee8a1d7d4450a06f40334e34f70666f4daea"
    sha256 cellar: :any,                 ventura:        "6873340fca2b05129622d2599ea7e4737409f7fbcf40e48cc63eb20e0f9517e9"
    sha256 cellar: :any,                 monterey:       "0d2d3fb842c8cac7fc536d7712b42439b746bd7771ef46729959c72704feb2bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d38859c5dba848575f6c0a15434e5dc90a35a81d8eb3320d5fcc79999841874b"
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
    inreplace "ext-src/php_swoole_private.h", "0, NULL, 0, ", ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
