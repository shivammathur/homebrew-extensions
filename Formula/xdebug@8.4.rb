# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/b68dfffa6d8c2dac7f0e4028b13b882562aa0c3e.tar.gz"
  sha256 "04ddffee04961dd6269a85206d1ec3847f6f60b5d75a4617b79fd8197dd1f309"
  version "3.3.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_sonoma:   "a9db6bfd772be6638846c6974572d885b2fc439791a09caed0719e7543f7bdbe"
    sha256 arm64_ventura:  "be6b7c2367bdff99fe436be338075bca0f002f0ec74c983f23ed9d7a4633cf51"
    sha256 arm64_monterey: "537c8259acb9e34b50dc501a0112c174e3186a389ad800c206dcfbad36055e33"
    sha256 ventura:        "aaea95d4f0dcfa52bf299bd3480d7da3eea6f6b51f5726ba031da358e90db9ef"
    sha256 monterey:       "2901627536a982d971ad289ff0e3650ef8eb6eee5b5bc617694243b2c30d6f5b"
    sha256 x86_64_linux:   "f5ab9078f8a31f951079dbc192bb92abada555fa18c8502f2e2dbb69f361570d"
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
