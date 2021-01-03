# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhp81Extension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.0.1.tar.gz"
  sha256 "e98691000db198fbda0d87bef63b46ec6d7a3aafbc394b22eca91b9059a9e63c"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 17
    sha256 "94a0257d9146ea2964bb0da71636e496a5f77d35ddc3bedd82054bd8bf5b9a7c" => :arm64_big_sur
    sha256 "20440a3a4dcaae066cdd89ad0071bb3fef90001e357b4ffe16725e46eed9eff8" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file
  end
end
