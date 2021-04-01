# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhp81Extension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.0.3.tar.gz"
  sha256 "1143f8f9677c677106e846f0d22fc82f4ee5ffb52bdd1498a28cb0748186a8c9"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 4
    sha256 arm64_big_sur: "a9a1689487b9a69ab111ec00e0fcd73debbaa48ccde8d24c35d0a9a4b497fcda"
    sha256 big_sur:       "27f22f98ea9b5113eac35f65a334b1e3ed5a341e5e6b2507190d8c7f6c1d505b"
    sha256 catalina:      "cb507b448a2f0d9f2ebe49cd54d001b4d60317a59de12ff731bc5264823c01b2"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
