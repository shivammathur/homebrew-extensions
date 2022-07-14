# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT74 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.11.tar.gz"
  sha256 "b81c682e4b865d6e3839b8b83640242f54127f669550111f5e99fae80ef1e142"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "0b12357718acbb0b0d2ceeb8ae35145168fa9b365895d22fdeb51fa9ce5cf3e9"
    sha256 cellar: :any,                 arm64_big_sur:  "a67351bae146e731a9c60d084970f821339cd3be19155c377aa38c4c9004c5a4"
    sha256 cellar: :any,                 monterey:       "ecdb95cef9ff9d39a67b6670244c365b598ce4152b91228ae308e1e6d610d010"
    sha256 cellar: :any,                 big_sur:        "bfc04fcf8d9271f802957979c76126214abc463c62a77c15afc23c8a4da6ca22"
    sha256 cellar: :any,                 catalina:       "836cd3b994ef29a038cd2fa48c32e722fdc1356bd0a9d5387cdaf40a200b4443"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "72ea3a5c89484af984801b2888d23eadaf6f987bba395a7bdc2614d7558f1861"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
