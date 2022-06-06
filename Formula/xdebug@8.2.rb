# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.5.tar.gz"
  sha256 "a74378597a29b6393db52b23698f2cf17b8dd589f032049e252153edb868213f"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  patch do
    url "https://github.com/xdebug/xdebug/commit/06c7f670e78fcd7867daf30d10eff785a50e033d.patch"
    sha256 "0ecd654aa184bf5974532d107d92dddd4337bac834a1c712d2dcf73c3545aeb5"
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "148f99aa0896f4e978fbf7c88fd3c774963df19e672a79114542d5bd48af727d"
    sha256 arm64_big_sur:  "b877fb10dfa1c21e59b06ac4f6a86e8e73e3f497a058cb191d4537a19d7b9e31"
    sha256 monterey:       "ef447afeac13f678748313f440078b7912b5bbb78ef64bee22e436796ee5444b"
    sha256 big_sur:        "4d4ca657cdc2bfa1521d639f5963f5b74254bf6b37f627e39780ef5a79bcfdfa"
    sha256 catalina:       "0077b508c8818123993c7dcd3a4794b911e2ac8b2f3c33b5c6a038101ccf8c64"
    sha256 x86_64_linux:   "49555c602c7e5ed178e636c4c4d1fe610eb178d35fb385efadf238696436e5bc"
  end

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    inreplace "config.m4", "80200", "80300"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
