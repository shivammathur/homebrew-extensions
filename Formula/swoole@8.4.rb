# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "7dbb9290c63062f4119ca772b78afe445f4d3508121b7e58e689da548da8055e"
    sha256 cellar: :any,                 arm64_big_sur:  "2c20958325ec7ed179075483cbfc62e6656d81fd1f160a505ff966642cd19583"
    sha256 cellar: :any,                 ventura:        "8a3a3354444e82ada70c63cfdb4feb9e46bea47379a6770ef5a5750c7c33e77e"
    sha256 cellar: :any,                 monterey:       "43db543e9897d40abdceb071d1126bf9c936432793056073ba2e5e7be1f7c549"
    sha256 cellar: :any,                 big_sur:        "1aef35f777c793bbc91d8726ab81e7df06ec22c1a951dec2ed422e075c46da65"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "092fe1188c2d753ff228a3c3252327e06eae43e28e9c1330ae6f4b3b429bbfa9"
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
