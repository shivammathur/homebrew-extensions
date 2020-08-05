require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class XdebugAT71 < AbstractPhp71Extension
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
    sha256 "366dbd2e1e01d3bf5c770a3a31bf3874239e59f850821bbcae499ea6f71a2157" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file
  end
end
