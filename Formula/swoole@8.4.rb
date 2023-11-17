# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.0.tar.gz"
  sha256 "5a987a4e746f0909762f44fcf098fccb77f58f80aaead8efd0240402940a3110"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "c472fe6af05ee7b8988a7eaad0a05e2235ab470366eafae8e355cf45a529ef13"
    sha256 cellar: :any,                 arm64_ventura:  "bf5e38d980a4d5a965b65361c426264b0f75b13b52799eba33ef424ebf3da050"
    sha256 cellar: :any,                 arm64_monterey: "51263843231cc4dbc5956ebcf4766ca374710eb57b2e17c17ff91814189cbf28"
    sha256 cellar: :any,                 ventura:        "d602f999889dd987161d78be7f1a4e2f66a350a1dcf45c0dc8fac511b8a687c3"
    sha256 cellar: :any,                 monterey:       "db7d51f66471876523ff78b51d06f010ee239c716133bcb65c81ffe76520fabc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c93339ddca7299bee4bf8122846a4c78d6d27fb2fe50856049cb469fbb768c0d"
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
