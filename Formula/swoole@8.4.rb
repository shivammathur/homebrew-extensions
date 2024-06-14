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
    sha256 cellar: :any,                 arm64_sonoma:   "fc3c076bea4325205e770aa9901b4e723f0ad30899b56492a63b2915bebf973b"
    sha256 cellar: :any,                 arm64_ventura:  "6262ce8dc7faade366061fba60783e6b3e6d25409a1b91ed4b326b139f9a211e"
    sha256 cellar: :any,                 arm64_monterey: "1ac2762729062b1e169d34410c0f37754c4da74bb01879bb416a14b59a0a8a3b"
    sha256 cellar: :any,                 ventura:        "a89378bd32d5c6f2c767615e16219e53501e57be706a56b6775fe9591549a447"
    sha256 cellar: :any,                 monterey:       "e4a8b958d248fbb743e15411be04b102c90d7eeea32d2a4cbdf252e280243d13"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c30c23450635793800ec995ea747447f59a1141707cefd40a7f463bf8b4c4460"
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
