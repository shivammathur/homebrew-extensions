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
    rebuild 4
    sha256 big_sur:       "89e9ecfb8220feb18207d2d69deeeeedfa9d53880434b1674e9e7dcfd0864c64"
    sha256 arm64_big_sur: "3f4fe24ea56a4e0543e382f59f5ec7e85a262133babfa719daea3c2f932a8e1e"
    sha256 catalina:      "d91cfbfc3aa3e47c4a0303e7bdad175ad29d5c4e2e68aecf89e47f49a35f67dc"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
