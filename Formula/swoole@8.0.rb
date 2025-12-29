# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.6.tar.gz"
  sha256 "0df87a2257f800607d38b6c703789facae5e1d9a9e78cd4a52c3fdc9b6fb64eb"
  revision 1
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "a4a21a27bd9d059ac9fca838805f6a46e9236433dce05638c931567b6839938b"
    sha256 cellar: :any,                 arm64_sequoia: "7fe322dcef0245b843165ea5c8e85a643bd25744c234bbeff5cee7e633654408"
    sha256 cellar: :any,                 arm64_sonoma:  "abe4a0fba06fdd9e3f4c08b00c79a728a29391dc8e72b943a1508fd5b723932a"
    sha256 cellar: :any,                 sonoma:        "b763a645cdf956d3e0a2e9c32f28462f013dfbec63fa1e2c22ca15f7025c9604"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c24ab72a36683849dce28383932fa650354abb3fa07745d581a27b870e46583b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "88a99ffd1da764a1afe692522902cc5bf11c38bcd3ae9957f974a2647b7b4bec"
  end

  depends_on "brotli"
  depends_on "c-ares"
  depends_on "curl"
  depends_on "libpq"
  depends_on "openssl@3"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-cares
      --enable-http2
      --enable-mysqlnd
      --enable-openssl
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
      --enable-sockets
      --enable-swoole
      --enable-swoole-curl
      --enable-swoole-pgsql
      --enable-swoole-odbc=unixodbc
      --enable-swoole-sqlite
      --enable-zstd
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
