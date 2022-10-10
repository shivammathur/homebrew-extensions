# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT72 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.0alpha3.tar.gz"
  sha256 "10fe3f5bb20ed104fa55e11e2c8616bae94fbd8286b3f2388639decbfe7dfacb"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "096df28694343e5c4f189f09e9f4fa56c4975179ab42f78cf9482966856574a3"
    sha256 arm64_big_sur:  "ed1646113897715894ac0aac486ef95679766a8fe1efc53b315cf3dd3ed0bde1"
    sha256 monterey:       "ca75d58b231c8e75897fb876fa1e16dcef817199e4f1d4ed788b578489af593a"
    sha256 big_sur:        "1ce5ab681c1b187ee04b32fd472d0d115987eb42ff45a7870b7cf4e69db69386"
    sha256 catalina:       "282449208e1a9f71ae3eb56d62980576a7258a7e211ff4ea9e81c2727d501f0b"
    sha256 x86_64_linux:   "7bf33768b6ef4869fd4587e69874d5a63b4763da9c6df174ef0ca928bf99da3d"
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
