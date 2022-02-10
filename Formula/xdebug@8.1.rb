# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.3.tar.gz?revision=1"
  sha256 "6620bf33db616ba52cc6b5976265d8962d8d23321ad5fd63b862c8d47eb5152f"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "f1a4b42d231228c8276ffdf52330d88cc4171497f583c75f7b47557b23f57ae2"
    sha256 big_sur:       "00ff13eda4d99ab693c80eacff125df63c15a6bcb3f6d51e9a6164b4cdd0d021"
    sha256 catalina:      "0201df495a2ba6417cb86ed84fe6b0a03a39eaa396d517b28cde9ac65fb7c0e5"
    sha256 x86_64_linux:  "3aa78a69ce7d90bd731d43b99764233de3ef1c4c983245f830dd49a80bde0c61"
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
