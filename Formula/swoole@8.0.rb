# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.2.tar.gz"
  sha256 "89d88ef2f7dfca96d4ff74febc62ec78ccbf92996176107cf30d538b30dee1ba"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "b9f115f6c4930156a86ef6aaaceec23be2955c61a5c2c483b5a89a387fbf4691"
    sha256 cellar: :any,                 arm64_ventura:  "74c6a1668fab993d63f0fd1db295de99d95a85231baeac79eae992929cd8b15e"
    sha256 cellar: :any,                 arm64_monterey: "b8e7044f1a2f8f9e0786a262c1d46c7ae18c8337e7aa91bbb47e97d26e1a4cbe"
    sha256 cellar: :any,                 ventura:        "2c4bddef6e4a8e2a7103a16639781ca3c1ad8071e5edf7062226976b5b8dbe6c"
    sha256 cellar: :any,                 monterey:       "ad863d50bc3c8b3283c548c33fec3f0ab25cf12b97a0de624259068fd1ff3396"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9e48fa76964ed7a68b7a40aa0a9e0ae2d223ebd012da6e10271b379a67656220"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
