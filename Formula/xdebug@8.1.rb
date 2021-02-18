# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhp81Extension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.0.2.tar.gz"
  sha256 "9b1b53468d35dfb3aeabf07c81e6de3b9ab6a7b15f5f5f35af3cac41bd70762c"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 6
    sha256 arm64_big_sur: "b7b8bb62a5c147573bf6f69b65299f4c24782df27588de8f2eb24c878bc7df32"
    sha256 big_sur:       "9a8adf812ce300bfca5844f150aa5cf8b7efc7f5a2e34471d5116668e56626bf"
    sha256 catalina:      "c137b6d770a81b668167de28a3fc4f8df17689dde47ec245d8a4fc71fdd1f2ff"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
