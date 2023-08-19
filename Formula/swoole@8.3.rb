# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.0.3.tar.gz"
  sha256 "c8d82949076aa42834681c738467d7448759ed8174d43a4ba40d8170d6f8da89"
  revision 1
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "8cc6c080c1ca54fa651ec20ebaf3e8ee1696aa435d86328807fbd4ca9bd70c07"
    sha256 cellar: :any,                 arm64_big_sur:  "15a9d618c7c5dd2ff4651f534ef9d9d1d170c62fce234b3e5f69823a682c1c5e"
    sha256 cellar: :any,                 ventura:        "70570a6cbfe53758ceae807efa1c16ef4b82668d367a798f77d7edf82ae540a7"
    sha256 cellar: :any,                 monterey:       "5c9ed12222a38ae4829d77fcb6f364cb727b6cd12a060bf2e37fcb44680134a4"
    sha256 cellar: :any,                 big_sur:        "7d63582a4662f7608d9311512dc2ed6e15cc56e440c0411f9d5c10cccfdf55ee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7faa98b9a38c8e9873c4a6f4e8d291a59a9b64c7c9a1712ee83b4ec4e58c9415"
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
    inreplace "ext-src/php_swoole_private.h", "0, NULL, 0, ", ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
