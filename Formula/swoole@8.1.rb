# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.1.2.tar.gz"
  sha256 "89d88ef2f7dfca96d4ff74febc62ec78ccbf92996176107cf30d538b30dee1ba"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "770bcd914d73c88de1382a6ac64a4d2ba48914b6d646cb28fef099ed01eba286"
    sha256 cellar: :any,                 arm64_ventura:  "a0cac43935468ce61a8e517c433ff44494ec653c14a2515c54ce9b6ab2216eb0"
    sha256 cellar: :any,                 arm64_monterey: "8c620c5441dbf5cba9df90bdb0caf1d587a8493453ea619c0c2a83b0b0af60fe"
    sha256 cellar: :any,                 ventura:        "098e523aeab2f7d6d021286ffe1524048ffc836969187e35bb3efa641e68a7c1"
    sha256 cellar: :any,                 monterey:       "2eea2862c62f74ca1df7b5e83081764ba58742b9aa271a3f0dedbaeee936c937"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cf86c137151dafcb02b8260b6c97d584a425f7ef986c970f811367c773f7489e"
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
