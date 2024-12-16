# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.0.0.tar.gz"
  sha256 "fade992998cd89e088c46c80c0a853ef620d4a883de698a913b2dfe7f842d5bb"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "e58d5ba124031cdf76cac4dad609ee1a8a1b683dc64e69bdb9263e001d2d6523"
    sha256 cellar: :any,                 arm64_sonoma:  "919390f73df2f1884b56a76dc1cfa248b15ae3ff9c25fbdcfcd85042f57660b9"
    sha256 cellar: :any,                 arm64_ventura: "b0a9266c937d4f47c6658d2c3314afc97ed337cf3259a0a936d2f6872c35253b"
    sha256 cellar: :any,                 ventura:       "429589e7dd5b0db9b18f303c308ae53995a826c73b7137b7bd45330766ddba4c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ba3de9b5a8d5778f89bef80938a341422c2115eaedb22dc244645854d5295dfa"
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
