# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT83 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.0RC2.tar.gz"
  sha256 "440639389c11dd81bda74bfd73b76d38153989d959f82213127a1e31bdc6be4c"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "e22c7ed69c77d231be4f46ccd4e7f5b647f99b202b1ab59c75714c5b529740c7"
    sha256 arm64_big_sur:  "8ee59a7d031234cc1c70f09b0f373147f4850def5f57bb0a35e405292eb5a300"
    sha256 monterey:       "465f112e73bdd6fade4c732598f162448131d0dcd5943fe69b2b880ee73bb6d4"
    sha256 big_sur:        "1646bfd4ac62f76973da6ba8019df0bc1dbb4212e44a814e6034017a037d6d91"
    sha256 catalina:       "4cc2c86314f7b8822df13bbb9e244f763fb91538c3d8f4b99bcfe202791b8cd3"
    sha256 x86_64_linux:   "c1e2a98bdabdda8c21dee17c86866a1c950102bf10b676672615d5923dbd1cc6"
  end

  uses_from_macos "zlib"

  def install
    inreplace "config.m4", "80300", "80400"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
