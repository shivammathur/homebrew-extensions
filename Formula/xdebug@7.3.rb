# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT73 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.3.tar.gz"
  sha256 "6620bf33db616ba52cc6b5976265d8962d8d23321ad5fd63b862c8d47eb5152f"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "c595963bd8197117a8740f28076afc7373296ba0d9bff9cef72bcc6e8defee64"
    sha256 big_sur:       "d9f0df52a8afcbb47b8a0693796ee9daab16f991959944bf180d97f9c7f799f5"
    sha256 catalina:      "1531c7b0fda34a258f551baa0462079b59857e9cc64b3c56dd485e89c0320ae8"
    sha256 x86_64_linux:  "ef6db2739073bc69a9955c8241e6153732aaa059e9f68a2bac3fedba2869215b"
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
