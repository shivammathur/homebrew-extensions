# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.6.tar.gz"
  sha256 "0df87a2257f800607d38b6c703789facae5e1d9a9e78cd4a52c3fdc9b6fb64eb"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "e94ea9b482e784904ceca51d2e7a910dc214bc1d4ca44e7b112afb562bba6c06"
    sha256 cellar: :any,                 arm64_sonoma:   "56331495d32e63302ce0019f2da336c7290fdeed25e9cec4a0882ba8ac70d479"
    sha256 cellar: :any,                 arm64_ventura:  "c0e9d2d27d561d0ec446e129f3d401c1a3115c035f8d3bdcb386f94a6eba1af4"
    sha256 cellar: :any,                 arm64_monterey: "6387262ba8518ad924c3f3e3f03829d6acda305084fc8d488aa756b4453a19f5"
    sha256 cellar: :any,                 ventura:        "272e4ceee47a152f9805e665e06c6a25e795536d9b49146ed45f628be1191bd9"
    sha256 cellar: :any,                 monterey:       "99dd0a0203e4b0a53f2bc3013c6dcb04f983e908e5f2b67b0fcf8ec4d42ddfb6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d91c061e4734302c6dfc089f6467990ac988488511f7cab25e45e94fa7609bae"
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
