# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT84 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v6.0.0-rc1.tar.gz"
  sha256 "b313a6d43699caeeba835071886b9f66093b2b181280e23073ee04840dacdcca"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "7456d5d35dbd2d3a3ad93d69cb5276e8a4a6077c9d4eb3f511c96045936b1288"
    sha256 cellar: :any,                 arm64_sonoma:  "13ed193fb606d1b41c9d41579decd3c8daff427498333a8dafbe6d5f3ceca601"
    sha256 cellar: :any,                 arm64_ventura: "6641802b00c39942d612b3a971e3057f12be1a81cc114af544186e594efda5b5"
    sha256 cellar: :any,                 ventura:       "861fc126bf97d4ec16e8ab647a2d3cfca73470c3fbcac9730939a61cc8f58731"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "596952c4d6a71fa29488e812017400545d07b555c46b7cb034ecda579e0b01ff"
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
