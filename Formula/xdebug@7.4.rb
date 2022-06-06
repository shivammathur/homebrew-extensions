# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT74 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.5.tar.gz"
  sha256 "a74378597a29b6393db52b23698f2cf17b8dd589f032049e252153edb868213f"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "35baaca5764b64748da5c883e38b0a9ae73bbccd066f750a2ea585cdbe05e6c8"
    sha256 arm64_big_sur:  "b02510c762cb11e54cfa596bcb1373dc74b00025038b293c3501dbff1107649e"
    sha256 monterey:       "e6c15d3be5f41fd4994b32bc692e4790adb125c9d98106c3a7e78859f9eb938d"
    sha256 big_sur:        "dcc9b8028958151e87b5885722c472f549d32ce35961ca05c679c72200658299"
    sha256 catalina:       "01a2b2fc675232dc6553d04805f98c1fe0fe2c055fed36c0c7d7b3b97f01e801"
    sha256 x86_64_linux:   "c3f031465412ec06400b61ddad306bf7a6a908493464819f1c3203f7071951c5"
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
