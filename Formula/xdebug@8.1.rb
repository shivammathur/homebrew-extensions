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
    rebuild 2
    sha256 arm64_big_sur: "398f6760560b75ee195d0d5b8d91bc8f161975cfd0e2faa71dcbd33fe8cd39e7"
    sha256 big_sur:       "9035ebe27442c1a7a540bf639f70af2585340bca60b1850b73b57ac610b38588"
    sha256 catalina:      "f388c7f96af988e527677f5a394050a08497ddaac3412b97acecbb4db7d1ebf9"
    sha256 x86_64_linux:  "a397c06605169d9cec5dc9d4edad747fbb141e46a8160b8ab2d176441be96636"
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
