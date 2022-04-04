# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT73 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.4.tar.gz"
  sha256 "be80d390b6fd425eef597563a4fe71a1fd153d2b9218f749023fac57e774983d"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "9aaaedf25ed978bc0f274ea9a5dc28e5393ed8a18eccec92f583a8dc149d7b30"
    sha256 big_sur:       "35bcec0ba3ffb715946efdce583aa856dd02b16f1852a372eb281f560864fc29"
    sha256 catalina:      "94695b66f1f58252def398033dccde7e3774108d3007391b02d447387967e2f9"
    sha256 x86_64_linux:  "f1b46091a68748d1adfaa00dd3cb5539615f52335b2c9b9823879fb3a316156c"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
