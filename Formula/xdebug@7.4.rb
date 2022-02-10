# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT74 < AbstractPhpExtension
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
    sha256 arm64_big_sur: "1a22bea9ec04e6e257ca6f00eae37f5aff48a90eea74bb831b6d674558283b23"
    sha256 big_sur:       "452a9924a694230b2594b2e4d6d59609e378a107fe21ce276999cca83d8d704d"
    sha256 catalina:      "d02034c8c983e7c37964458f6eeea759f3f2492ab5b49d672e48b524a343406b"
    sha256 x86_64_linux:  "d452a8cb80a44d3fbc577518fef5e8ded02d51d57f4ea969f8d46fa7b79f8d1b"
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
