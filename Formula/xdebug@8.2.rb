# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.1.tar.gz"
  sha256 "f8d46e0127b4a7c7d392f0ee966233bf5cfd1ade7364cc807fe5397c7de0579a"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "17563f78f793c3714bb18c2f34b6322720e6f5233c946d6bd207bc10acae2fc9"
    sha256 big_sur:       "6ff9cb35d66f26cb298cea872c9d2984fb2104a08afe9e4237844345b463d4e2"
    sha256 catalina:      "bf4f6061165f156f4c4a21675597396224b02339ab1cc2bad1d036e32ec81c6b"
    sha256 x86_64_linux:  "5d0363ccc220504a5cd5a8c3d049f0b1c0c719d75cc6596cb6159ebc57e2a298"
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
