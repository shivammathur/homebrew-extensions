# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.1.tar.gz"
  sha256 "7c4ad3d65a5221aacf2428d7062be922ca0090a3bc9000f8bcf4cd98d011ad8f"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "f7db5cd9e06e7fca332da1cdae421257c89b53d728df223f4dd269e9353579a5"
    sha256 cellar: :any,                 arm64_ventura:  "dcd98246dd2045f5639aa461a3abf7cd7afdb4c5358b4793e85a75d1a0e7a855"
    sha256 cellar: :any,                 arm64_monterey: "fbbf473dec426e92a4fcd10df517ec17a4e6739f87eaf99aeacc7b025e613cf2"
    sha256 cellar: :any,                 ventura:        "ffaf30b00b4c0a08cf9b95693583ccdd9909c00eac23106a76a03ae40fb135da"
    sha256 cellar: :any,                 monterey:       "fc0062ac27facf7977a492a9592a3c251330351e6ee775b42fd6fa558e153a8f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cd167ea05366fc772d24fcea5d4814b563677501a6eff01497a013492a1e9ce0"
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
