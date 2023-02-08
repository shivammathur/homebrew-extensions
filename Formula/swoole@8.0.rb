# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.0.2.tar.gz"
  sha256 "14d442d5e945fe67a3e912d332175b2386a50c38a674c4559d2d0211db23362e"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "53ca2363ef253d163d82c0847bf7e9eb330f50fbec4dd39ef9065c199c0db127"
    sha256 cellar: :any,                 arm64_big_sur:  "30ecc714d1056c027d8441785552312f4dcdd5ffcd853039e0948f1c309254e2"
    sha256 cellar: :any,                 monterey:       "1c347c051be1c5fd7b6f8a76b762a50a1d936b117c319807911f948e9c74a9b0"
    sha256 cellar: :any,                 big_sur:        "7478a28590d6a5a9556bb160cf17b5de15279503a16a182aa1b9ee0863b0cb7d"
    sha256 cellar: :any,                 catalina:       "29d93858aabbe5305b8a0715de359a1ebf209764caa44a1814e751196869997c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dc094971c413e9b4189b2385d0b31c349bd0ffd1863d85555f7339d2296392be"
  end

  depends_on "brotli"
  depends_on "openssl@1.1"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-openssl
      --enable-swoole
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
      --with-brotli-dir=#{Formula["brotli"].opt_prefix}
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
