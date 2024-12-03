# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.6.tar.gz"
  sha256 "0df87a2257f800607d38b6c703789facae5e1d9a9e78cd4a52c3fdc9b6fb64eb"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "90fac773fa500d5f984826bf1ed0c39400ae10c16bef48d4ce6ff009c98cb09e"
    sha256 cellar: :any,                 arm64_sonoma:   "035a2d91bcd7f5ac3567abee4bdb6848008c114071372d6fe7f6f8e955d2c033"
    sha256 cellar: :any,                 arm64_ventura:  "814cd90ab5b7e589d64a6460b1cbf70c7547637081a9d4e436484872a06d7152"
    sha256 cellar: :any,                 arm64_monterey: "54d86c5d57b0978ac2a317edc8c625f39898ef35df8ceefc5ae06508782595dc"
    sha256 cellar: :any,                 ventura:        "a15a9ab42e5afe08bc4c04b605bb0b86a76d71f37c0f663a0a5a1464b2761966"
    sha256 cellar: :any,                 monterey:       "81eba9cbfb0a7c78e4b845432f4e20f7b116f81bbfe70309cbbc963f2b299035"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6152bf7b0299148b977665a96e4ee353a0d1045d3ce227cf6cb94cd1a0a1a4db"
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
