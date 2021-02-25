# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT73 < AbstractPhp73Extension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.0.3.tar.gz"
  sha256 "1143f8f9677c677106e846f0d22fc82f4ee5ffb52bdd1498a28cb0748186a8c9"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 "424b1525234c894dcb92b934d5326af48bdf9b2fded26022ebac07eef77b777d" => :big_sur
    sha256 "d54c54c6bad0fc5c58fc209b6a0ba9fa0272212f8b1b5266c8fb9c054bf142c0" => :arm64_big_sur
    sha256 "5b179bef58f870aef3d7b75c5f928aa5b916b014dd72f3949eefe6494dda45ce" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
