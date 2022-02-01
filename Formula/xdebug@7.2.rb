# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT72 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.3.tar.gz"
  sha256 "b8f54da6bdac2dfce2137c8ff4adf2c39c7f7001a806270e07a4d0c25f791f06"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "29aa094496c656e16b71237c6f5627ab736d88245eefbc842d5faa4d60ab1fa6"
    sha256 big_sur:       "da6d30c4a9dc52313a3119fa43981fc607ffd7537621ffe285269cd88837fc8b"
    sha256 catalina:      "9bc928a12144aecaf6f4a144fd2f952648f6fcc64c60abda505d8bf6b7ddfdad"
    sha256 x86_64_linux:  "9b2f6cc9a7a06143eb5a13056cfea881165ff8c73ad95416816fa44485ca27dc"
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
