# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.6.tar.gz"
  sha256 "0df87a2257f800607d38b6c703789facae5e1d9a9e78cd4a52c3fdc9b6fb64eb"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "bc0b90b23228ec18beba7b6c59cf64918d0d08fa7f4b0d23f8767de95b76a6fe"
    sha256 cellar: :any,                 arm64_sonoma:  "e8f35c2a3e9a4e838a5d2b04d6addc7239329979823ebc284198aad379bd6545"
    sha256 cellar: :any,                 arm64_ventura: "6e89bff9056574767ebcc0213acfc6530ab404e8a11eaff0134bbd18de35ac36"
    sha256 cellar: :any,                 ventura:       "fc9b4936fbc4093911a9c564fa590207051b26ee48986cade3056c3a91f37a75"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "084fc0f9fce45ef93bb02f70fcaec2cabf59e90af8be5be1a47bab4a06d16351"
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
