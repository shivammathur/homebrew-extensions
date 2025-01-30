# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/cff20f94f51cfc50c3aed9df27a6991017765560.tar.gz"
  sha256 "64adeab0e98107ad7015ed5e82171b006f2bb3973a7558fc7176b21256b7f242"
  version "3.4.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 arm64_sequoia: "49f2a0196b179b6f3563af676cc79111702ea14ab4bf863de785d899a1609b99"
    sha256 arm64_sonoma:  "3e83b20b063a3f463265b13976cc5cedf75fde0c0fa7927a711a732f1605c135"
    sha256 arm64_ventura: "12b90f0c2f10f7e0d07650575abc2bcfdfc5f2124e0d9a2c72641bcc3fc79864"
    sha256 ventura:       "1cc6eb4bb048c46af4d9c45c848573d04a9ae8460a24f03e97f3e22cf77629e5"
    sha256 x86_64_linux:  "7f326b32d8bf05bd0b0a4bc1ce4a7303ea5a91a56b779f5a6fa839de91735f52"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
