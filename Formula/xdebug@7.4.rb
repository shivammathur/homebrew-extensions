# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT74 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.4.tar.gz"
  sha256 "be80d390b6fd425eef597563a4fe71a1fd153d2b9218f749023fac57e774983d"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "7413441ebc43a0b83bf672872113ae3e2f77a2deee470fb9c7b916bb1a7e7355"
    sha256 big_sur:       "e468106bba0ba98a2c10ed0dcb3c14c9beab8fcab01a805f2a1f695922deeb53"
    sha256 catalina:      "3793f0a90be61d5d998be78c0ba3ffe2070a04ab65f3437a36c422ebf3fffaa2"
    sha256 x86_64_linux:  "46e174dc338bb0ee261c14c3e226fd9500265f2de0dfccedc47d3b3f8a11bbeb"
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
