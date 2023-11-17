# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.0.tar.gz"
  sha256 "5a987a4e746f0909762f44fcf098fccb77f58f80aaead8efd0240402940a3110"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "55275f4435125cfeba245afa19b9e006579e14cbcf66c7359381eab79f9180c9"
    sha256 cellar: :any,                 arm64_ventura:  "313919f22adcf4ec4612573cf3d4716a152f7e14ac58cdad9a9299d3807d08ed"
    sha256 cellar: :any,                 arm64_monterey: "f010cebe470e9f20f136cf55fea7dc3b0236f100b6275dff073d221ecce7ea45"
    sha256 cellar: :any,                 ventura:        "c3d04045c9dccfa17bbb0af0889f7c0371d47ff1a79feda9bdf340b6ebb0094f"
    sha256 cellar: :any,                 monterey:       "45814cb9367b676f95e7a8b8fbc361b9af6b2bf5860d0c6a444d17a41921bc98"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6e4a80c7b8d6c76b8a9192163d5db97667024ee1509ac85fe51c836bbbc53fd9"
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
