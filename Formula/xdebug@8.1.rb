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
    sha256 "883838680d1cdb06e2c3e493b6ea09b3b0c0d48599dd29898060035cfbbbf47f" => :arm64_big_sur
    sha256 "32ce8526e9174afd90740e44dfde6b6e3fd7f63dd1521f953c8b075ebf5617bf" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file
  end
end
