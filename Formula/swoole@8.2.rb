# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.0.tar.gz"
  sha256 "5a987a4e746f0909762f44fcf098fccb77f58f80aaead8efd0240402940a3110"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "055b54dc9be1a3b9a84402fa4513b3802aedefe82a2bf1a94ca9601a0a6d873f"
    sha256 cellar: :any,                 arm64_ventura:  "c126f3a2268bb3ff28bb262192c7deb71cf92c4715eb4e53149b83886e682795"
    sha256 cellar: :any,                 arm64_monterey: "c86cbe4fb96fa7b3bdb91ea274c3df21ff8c46023c3a036a0cfb275cd60ef803"
    sha256 cellar: :any,                 ventura:        "0c015fb2369c3bed91695ff7ff4d05b7943cc08e4ea9bd25ab5b94b3dab3260c"
    sha256 cellar: :any,                 monterey:       "dd2318271e84b1721fb5e5dbcbebc30ad1f7b912683aeeadce64dac2bdc7d24d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4adb18ae8e0fa48235c6c717cbfb004090632bd7296c2bca12c7b408e5d0ef2f"
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
