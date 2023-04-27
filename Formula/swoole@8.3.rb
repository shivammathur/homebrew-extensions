# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.0.3.tar.gz"
  sha256 "c8d82949076aa42834681c738467d7448759ed8174d43a4ba40d8170d6f8da89"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "66ceb0b276d704ad11068f250b2ff0470ab663de59558d659d47926c02e7f468"
    sha256 cellar: :any,                 arm64_big_sur:  "f9c08f2291c3b37bf1e49ff60d00beff06f7029537aedc681ec7b49aa6c720a4"
    sha256 cellar: :any,                 ventura:        "de2ef03257cf60c424307653c596fbc0d2753bb16e39cf9d04558eb3ab2c50cc"
    sha256 cellar: :any,                 monterey:       "0b145419ddde0ef780f816dfc2ee58d4917283d3af8047397de8b0a2f42a5971"
    sha256 cellar: :any,                 big_sur:        "7dafa138b8a173b41839e4fa773a57eb03eb334592fad70a8e16cb6664838500"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "88169f2819789eecb8da3021f753e35ffc350de7d8b5cc94985e9d3eb475aab3"
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
    inreplace "ext-src/php_swoole_private.h", "0, NULL, 0, ", ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
