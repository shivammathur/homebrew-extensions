# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT74 < AbstractPhp74Extension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.0.3.tar.gz"
  sha256 "1143f8f9677c677106e846f0d22fc82f4ee5ffb52bdd1498a28cb0748186a8c9"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 arm64_big_sur: "2ede56301c44ae96bdfb9f9b9b5556a84f0d77a55a870ccb97fdb5a2bc904848"
    sha256 big_sur:       "3a2a033330204919d011d4dadf39b370b10b6273f36b81630b6cbcd946e1dfcb"
    sha256 catalina:      "cbcba095932f3b86782f9a6d5bdb3ac4cb83c33d2566662e07b005177999a323"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
