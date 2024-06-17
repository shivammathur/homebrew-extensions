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
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "6b7be7fe638d641c99c8fcb18441255033a6e9041d7d4b0d202eba242cca84db"
    sha256 cellar: :any,                 arm64_ventura:  "8070c3be80c99668b491b0115c4f82a5a1f829bac2acd5b79ea4befa2c6cdfe0"
    sha256 cellar: :any,                 arm64_monterey: "d6ac58f93231e1d14b18baaa7aa5d326b7f7b7acfc5dabaaaa44b4335361945e"
    sha256 cellar: :any,                 ventura:        "f45dbc1925b7e898c20a1349bf06d5009a73b513d2cb6cd31192d1a5f92efccb"
    sha256 cellar: :any,                 monterey:       "7d302e7abc84b6f121dadcdd74aa71c1944aaeca8d9ed0f8ff79b3a046271280"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "16ffef3a88e402d9fe358c87a632f56c4ccd1c05b828454c913794c9b85dafce"
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
