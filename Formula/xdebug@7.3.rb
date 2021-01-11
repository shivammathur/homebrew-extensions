# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT73 < AbstractPhp73Extension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.0.2.tar.gz"
  sha256 "9b1b53468d35dfb3aeabf07c81e6de3b9ab6a7b15f5f5f35af3cac41bd70762c"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 "d54c54c6bad0fc5c58fc209b6a0ba9fa0272212f8b1b5266c8fb9c054bf142c0" => :arm64_big_sur
    sha256 "5b179bef58f870aef3d7b75c5f928aa5b916b014dd72f3949eefe6494dda45ce" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file
  end
end
