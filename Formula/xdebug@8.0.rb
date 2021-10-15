# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.1.tar.gz"
  sha256 "f8d46e0127b4a7c7d392f0ee966233bf5cfd1ade7364cc807fe5397c7de0579a"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "d32882870735d93c3df63ab88513563f6e1b93698a28c8a904253e0fbadaf14e"
    sha256 big_sur:       "6cabf89fe8fe6696983db1b7892c3dd050ec707e31936be21c7a550db3abdc31"
    sha256 catalina:      "ff2f43369720c0470c804888cb205f247f43f59f19c7e66b09347d66b605699c"
    sha256 x86_64_linux:  "8e63f2a0bf719cec547f00715e1b435c63deebb22c11e3da2550078cf8b58c9c"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
