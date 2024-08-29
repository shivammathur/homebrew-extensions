# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.4.tar.gz"
  sha256 "753496d1832bea57126acd61bb7f9946a61604ee1d7e4ce7a48d1167c2801fe3"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "dc5737356466e05fb3ecfc63b36fb98802906681b90cbd3a2546dd2fa83db08d"
    sha256 cellar: :any,                 arm64_ventura:  "efa992a1069ffcbec37d19c2780cf12d455524fd86f5be76ab4a3aa7ccf32b28"
    sha256 cellar: :any,                 arm64_monterey: "a61fe94a2092113921eba4e6c2ee934017f6d27d42657eb3788c54775ea9e297"
    sha256 cellar: :any,                 ventura:        "1d3a3767e0337336eb3c586d7bf410afb654bf4c9fac33aab3ced70d21b4aa8b"
    sha256 cellar: :any,                 monterey:       "dde9a760e4013f07fd177901a9d5f6409ab229f5efe35972ac7dc71761ae5857"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5ed967f61117fec2b72665ef3629b2b19309882293ca2b947a03ee1aae44f7c5"
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
