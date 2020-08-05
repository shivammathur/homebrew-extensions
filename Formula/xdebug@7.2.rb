require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class XdebugAT72 < AbstractPhp72Extension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/2.9.6.tar.gz"
  sha256 "e330c5ccb77890b06dd7bf093567051450b2438b79fed8e7e6c4834278d46092"
  head "https://github.com/xdebug/xdebug.git"
  license "The Xdebug License"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "c4cdbf5fa4832fe53df95ff1631a4298554b00530265856fe6d9582334aed021" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file
  end
end
