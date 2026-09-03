# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/eb58f1bf89a2046564bf15b82b172325dce472a7.tar.gz"
  sha256 "27e1d58d9a9a27b329a9151e2c141ac2e251fad32381bd1c0eeeb61f7ec277eb"
  version "3.5.0"
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 arm64_tahoe:   "caabc3d1d5401c8006b2de596d871c93ff59d6685c82b69455073430e385aa58"
    sha256 arm64_sequoia: "453d3d095fe21361486cc70678cad59c7d56ed49ef1fd95966cd5aed12f53386"
    sha256 arm64_sonoma:  "8cb940bf41088c23aee49aca763b6b522256156ea268e3f028203d712041a16d"
    sha256 arm64_linux:   "7813e2fc6a7f174993a3c44e154479902453e8260b0872620f0fba19986b4a86"
    sha256 x86_64_linux:  "d8f8072d15429015a0a67346fbad6febe835e3830a56d09a466e86314be94d35"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    inreplace "src/develop/stack.c" do |s|
      s.gsub! "INI_STR((char*) ", "zend_ini_string_literal("
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
