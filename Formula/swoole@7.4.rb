# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.11.tar.gz"
  sha256 "b81c682e4b865d6e3839b8b83640242f54127f669550111f5e99fae80ef1e142"
  revision 1
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "c088f83396732cfad76645a2953c6d2bb3cff76ea64bce813992c60544001801"
    sha256 cellar: :any,                 arm64_sonoma:   "525a64fee37c7ac0ffa6103d791986b9fae9a1819c2843bec39492b8a747c794"
    sha256 cellar: :any,                 arm64_ventura:  "b4385760e08bca39066bc8839d06164f9d39446473672078e9a4dfb938d46bda"
    sha256 cellar: :any,                 arm64_monterey: "54ad00fe3c105e1706226e15e3f66e82c8121b91247a141c3f7dd15e90b6277a"
    sha256 cellar: :any,                 ventura:        "3891d86cb9dc5991b7fc8905765b25aeb5e5eedaf61066db29546a00b5dff889"
    sha256 cellar: :any,                 monterey:       "8eea3fbed33f3a5b8344a94fb663bc49c0e1c99322d39a60cad874f3c004e0f0"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "f25159d4b870e7587692717871fea5d33616fcf84dcfc3f679c9643877ec0fef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f01f00530ac935f3215b7ef29d73646d27901d7e19ba86c21a56769b9d19e496"
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
