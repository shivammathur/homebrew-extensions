# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.3.tar.gz"
  sha256 "dc7a24094fe86025de4a0fed2a94005d2266a29332e7e9e6be50238a8ef6cafb"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "e57f3b37c6205f98971ac74c766577ef8fbfadeb70e3393c0f7b5a554b6f274e"
    sha256 cellar: :any,                 arm64_ventura:  "dcd57b3dee9bd269a2ea4ce1f7e054c048451f12161500d1575f067200ba74f0"
    sha256 cellar: :any,                 arm64_monterey: "a7990cea60a0f62f223f06ba7c97f541e37fbd9dec296ac9cd3059910f6979e5"
    sha256 cellar: :any,                 ventura:        "69f40f71065d524249fa0f2a33aaeba537dbbba4400b4e369169ee60eabc56ab"
    sha256 cellar: :any,                 monterey:       "0a8a1e1aa2fa41cb99c3e5d0f00a0b70381bceb479b7f9ca7ddf8d64f4b07510"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "15378ad9d81f343451b3304e4019a3d33689faeafa48aec3313e907bb82a0e4a"
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
