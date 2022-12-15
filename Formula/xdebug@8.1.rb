# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.0.tar.gz"
  sha256 "a5979f2060b92375523662f451bfebd76b718116921c60bcdf8e87be0c58dd72"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "4adab6ea91fd0258a6e821e38c64f8d61b86f97ef3c0cf35fc0b2fab501f191c"
    sha256 arm64_big_sur:  "4637fa4915b63febcba16787020cfd19e38c0b3b36a98b38b8571c08c9afa3d6"
    sha256 monterey:       "f8c64471c6e6c3bdf8a149ab82d2822f09800d739414b01389aa9a5f8f85d87d"
    sha256 big_sur:        "3ee17a67e35016723414346b13f5d798db92d216654eed24dc74c07e4a98e52e"
    sha256 x86_64_linux:   "17c0af8f4f02473798857d04eef3ccea85d61b55f4fe13bf3f8f0bb8fa4d0bd4"
  end

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
