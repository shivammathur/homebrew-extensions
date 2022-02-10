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
    sha256 arm64_big_sur: "fb7dac7e2dc799dc92277d70b47485a963840129bf63fbe4abb5a74097ac97e1"
    sha256 big_sur:       "4dbfaf2e78c2094fbe3e568fb077843acba119c8237cd6ea85110bffce5f563e"
    sha256 catalina:      "3ac691337ec92984e212825f0503ab39bb26ac8f9231f0fba3cf77f512089075"
    sha256 x86_64_linux:  "656fd6ff2c6fa52b132097e4b2edae5f831b736c8c2a941e3321f1c3c08ee30f"
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
