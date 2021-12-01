# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.2.tar.gz"
  sha256 "57cd63b25649171218c749f8fed808dea7d641bc4fbb4427356d00056ac24c68"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "7371dfbf39cef16134626f652554dc56622d5acdd731456ffc7b86e3933449f4"
    sha256 big_sur:       "84ffa0f73d8b6722e9a8105cc5bc065fa14a1d037eed5b01e7676cd6d0e3d49a"
    sha256 catalina:      "5b6cda1878f164470a334251009a28c4f3c7663929e5e605d397b7a8184086ea"
    sha256 x86_64_linux:  "c3289cd99afbdb659d8a92a198a618d60dc0d0e0ce43f32392a087dbfb431206"
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
