# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.0alpha2.tar.gz"
  sha256 "3db2ca7b20830b790e3a4ddca93a0cbc12bc768beeb50b930c9cfc0b4874846e"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 arm64_monterey: "04d5a658d3e95482c501395a49cdafc583c7975ee79ba294de7aa361b19e14c0"
    sha256 arm64_big_sur:  "d35a0a0d302f111d486d508351ad431d22706d6b0761d3169a9664375e421f9d"
    sha256 monterey:       "0a61acdb8daf741bfc1e664d6b5a70798fc4c5b4bbc1e97aafff4d6398a1babc"
    sha256 big_sur:        "b43481202ec5d95e7940cc373a9873687043026b1c7e2d411c1d6505c23757da"
    sha256 catalina:       "5137046657e48a78dbfc71eb355374d28233a3f020a37814ef2c9828f843cb4c"
    sha256 x86_64_linux:   "aea37e29d677b9b2294b259c2c3767d97bb7f4650298aa45219cf1c092b45d61"
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
