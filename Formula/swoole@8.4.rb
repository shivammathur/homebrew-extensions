# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.0.1.tar.gz"
  sha256 "c1e35bbb4714e44d3c180a292ae2b55cf94de8d8f2a3b197d1e844f866a0e5fb"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "054718146d538b5e8521e2330b14077b708c913643f8ef13ddc6970f63f31bcf"
    sha256 cellar: :any,                 arm64_sonoma:  "719060a3fcab14216973854c8041101822c97511dddbeff824348e52786595f7"
    sha256 cellar: :any,                 arm64_ventura: "77c99ef2abc6bcf32b832449f9b5d0c7f808795247d703b488f0161e8ee6e719"
    sha256 cellar: :any,                 ventura:       "914e4863c13726cd15672eb869609340403f85ef1e5709e0e8623511ac23859b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b9655ed74c95ec5655dd1a46c087fba0dc12a0b335cc397362a69f573ce8c0a2"
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
