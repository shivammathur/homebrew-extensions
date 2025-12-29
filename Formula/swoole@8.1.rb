# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.1.6.tar.gz"
  sha256 "7f022cf6fa2f273915fd09f94ef019c50efa06b0be01eaadcb4b289d5622d77b"
  revision 1
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "82e9fdeb1e959878bf0a13832ac3095e57cb7c53190f7ad2e71993f6bcc5273c"
    sha256 cellar: :any,                 arm64_sequoia: "ebeaa101f903ffb9a8263ee0f22bee04c76540e819c308e59002bb2a7e7a9d8a"
    sha256 cellar: :any,                 arm64_sonoma:  "a909e0dff8efd8b8a9881ac652a4925c4070e6cc399ed5b694fc53e6e9b2e91b"
    sha256 cellar: :any,                 sonoma:        "6cb9042c442e768190181de054bd140eb6376674440c4bdb91e98f3354c177e8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cebc8318eb26dc3c0f8be8770d798fc0ded69540ee110b5d06f465953dc87927"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e8cf4e55769bc8397fbc7f354e661022292fd6655813cc8a845a4848427d67b1"
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
