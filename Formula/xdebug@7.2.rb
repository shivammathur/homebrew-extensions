# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT72 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.0.4.tar.gz"
  sha256 "7e4f28fc65c8b535de43b6d2ec57429476a6de1d53c4d440a9108ae8d28e01f4"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "705b1a3b1d085efbb69e027fef5fb071aabbf738c84ce2db279ddad972ce712c"
    sha256 big_sur:       "27a5db465db007312b5a0af235fb694ce6978838876cef8c08ca17f5d4aaca52"
    sha256 catalina:      "cc84406fa02a01deeb729524a2e1986a6463df90a473d8bf70e0cdcf85ea0385"
    sha256 x86_64_linux:  "558baeb9b07f02235a148ef89d67f0d1cc05a6d42222f68c0d9c3cec69dce11d"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
