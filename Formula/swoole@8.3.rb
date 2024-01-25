# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.2.tar.gz"
  sha256 "89d88ef2f7dfca96d4ff74febc62ec78ccbf92996176107cf30d538b30dee1ba"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "2303dd83649676c3510778fec0c2ffb8990d5e23d552dd8880ecf40db00e0eab"
    sha256 cellar: :any,                 arm64_ventura:  "ace53fb9b0dd902804e6dd58a10c12d2a129c788e493b7f517a4f2930be7e3d4"
    sha256 cellar: :any,                 arm64_monterey: "993e63ebbf9b225a21b97886a5881cb2c55a7e3620cb8598ecf5dc23f1f73522"
    sha256 cellar: :any,                 ventura:        "0c63dd330e8537483db15be8fd07adc9f6773f558811291abe51409a380fb557"
    sha256 cellar: :any,                 monterey:       "ac5aa760bb24e2369ded29c6ec8ffe0ae1f03aefc20de053126989c646148778"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a7ad302257ffeffa417890d5eba113d430d1bfb17a567436a1b4508db81af446"
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
    inreplace "ext-src/php_swoole_private.h", "0, NULL, 0, ", ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
