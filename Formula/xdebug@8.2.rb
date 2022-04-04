# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.4.tar.gz"
  sha256 "be80d390b6fd425eef597563a4fe71a1fd153d2b9218f749023fac57e774983d"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  patch do
    url "https://github.com/xdebug/xdebug/commit/06c7f670e78fcd7867daf30d10eff785a50e033d.patch"
    sha256 "0ecd654aa184bf5974532d107d92dddd4337bac834a1c712d2dcf73c3545aeb5"
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "286c1b4eb11ed9877cb503ae603d8da74ba58f2a2af226fa66071e2a67bba392"
    sha256 big_sur:       "19c03f69a7c99f3e58be5d5afcd76a7ec14fcc1077d8f435458e969b2813d9c1"
    sha256 catalina:      "7ee3364eb0253c98f36d1bad07347af22fc769a432f452883bd7d3c137c7f879"
    sha256 x86_64_linux:  "25cdfb0858ad5483d35c9a54bb61ea5783c36a1d96ec1ba91112337e6dcc2136"
  end

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    inreplace "config.m4", "80200", "80300"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
