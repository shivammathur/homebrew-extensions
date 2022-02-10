# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
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
    sha256 arm64_big_sur: "c861ab1e27f5d1ad349b7578c4e5f1bdb99761e58f6fbbfe863a98658adb296a"
    sha256 big_sur:       "0a2c353adee3a199e72465f5f2d4bdfa4a2040ec1c5ce16035fa3dcc7c5f37fb"
    sha256 catalina:      "bb2aae41446121f35d671cb3a4012c060604bf0cb934b20a544d5f55bc8def96"
    sha256 x86_64_linux:  "c3ddae730e054d6f7661c4506f54f2abf3664a54af58ca5387a7af2b9e17c3a5"
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
