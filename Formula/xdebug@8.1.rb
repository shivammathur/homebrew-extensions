# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.4.tar.gz"
  sha256 "be80d390b6fd425eef597563a4fe71a1fd153d2b9218f749023fac57e774983d"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_big_sur: "cc20c0cf17ca4b6db55b789e38abb889ef2e23d4afb3b7484b80e226b9a07955"
    sha256 big_sur:       "26583499df994976ba5b0475c24a9be0a97c56e89e8e0ec9077f2cd129864999"
    sha256 catalina:      "578a6a0ee59084dfb38594fb2d8b2f450fed96cd46fae26aafa45e9e041a3a3c"
    sha256 x86_64_linux:  "ec400af7d53e49da32b1524b1bb254f655da9caab8b3e89cb9a2dfb120750efd"
  end

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
