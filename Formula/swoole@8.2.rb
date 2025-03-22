# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.0.2.tar.gz"
  sha256 "b0bd47292add791b3bcebf347cd593c98a71c098dfeb96d125193bc95e95ed2f"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "4d5673724a786ecc4b6d7b94acf6da2c0523dd2eb4bc1ad3b956bc43f4b72b8b"
    sha256 cellar: :any,                 arm64_sonoma:  "04598c33aa5d9e570018f13c63a090eeea215ebf093e62a6571a852f419fcc0c"
    sha256 cellar: :any,                 arm64_ventura: "8261cd01012bd546122bd26d4c34d42dc849c0185d0b2b2762be8aeb0cb8bf09"
    sha256 cellar: :any,                 ventura:       "846d346e846a48c240c86dd99487905c815c7be1103100245567880adfad8b17"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "824c8ef47d3263e44ac0691621759838fd8f7781042bcdeac8f74c973bdd2903"
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
