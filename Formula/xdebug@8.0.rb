# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhp80Extension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.0.2.tar.gz"
  sha256 "9b1b53468d35dfb3aeabf07c81e6de3b9ab6a7b15f5f5f35af3cac41bd70762c"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 "101eb4c84a6e27fc71ec7449e0c6a9e50436271a0409a0d76ead5c90b900fc2e" => :big_sur
    sha256 "9f87a0ff476c2e9243f9c0b94492d1d9fd7a93b4c23a9c66aa89daa763280b4e" => :arm64_big_sur
    sha256 "1659f208556525a4f5092a564449202d94ad55aef32e53fa2fabc502dfa2357c" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
