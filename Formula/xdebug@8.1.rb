# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhp81Extension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/master.tar.gz?v=xdebug-3.0.0"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 41
    sha256 "0a524de551dbb2d5cdb2cd8eb79d22852c6c6c431c5e0f4654e94f84db0cb252" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file
  end
end
