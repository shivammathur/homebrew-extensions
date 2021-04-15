# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.0.4.tar.gz"
  sha256 "7e4f28fc65c8b535de43b6d2ec57429476a6de1d53c4d440a9108ae8d28e01f4"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "6cee7aedaeff92c674d67ff7718c2f73c6c9af5ec1fec694630ddd71921fc788"
    sha256 big_sur:       "7f766654a5c22023b5062ce5f0ab2e3c3f1898c7c8bd9bb18c02e71384c200fd"
    sha256 catalina:      "c16cfbc55c9b11a841ea304070d39a2414be7c5fa3db7ae6ef34b7d364b6402c"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
