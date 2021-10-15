# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT73 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.1.tar.gz"
  sha256 "f8d46e0127b4a7c7d392f0ee966233bf5cfd1ade7364cc807fe5397c7de0579a"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "15ab475bb7388cfe08fb33018404118d948cebb7665babdee85613eda99a8627"
    sha256 big_sur:       "d08d48de42a58733a0311f3206b69842825e4f83128ab1994662d6189a2b9f90"
    sha256 catalina:      "48b2b3245291ea11b4400ec9322873bc9de8f1d019f5f60194afad3cd955ad01"
    sha256 x86_64_linux:  "7064ccec96609a4602bcbab22b78b023fc6cecb6c247f91876cc05bf2fdb464c"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
