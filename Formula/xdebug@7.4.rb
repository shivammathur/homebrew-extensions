# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT74 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.2.tar.gz"
  sha256 "57cd63b25649171218c749f8fed808dea7d641bc4fbb4427356d00056ac24c68"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "ea41db618653212bb5abe791348c76e1f2664e787ca8741ba7257bd77d9e603b"
    sha256 big_sur:       "a7103d59ce3d7f328a122f4de797c0ff06a03f635b211fa19176971b758c00f4"
    sha256 catalina:      "43776c0c3cd02eb5d17d88b012b75db7ae39617a814b90967740ed4d98f23ed7"
    sha256 x86_64_linux:  "15b0e914f91ec5156bf14e31d6dc5dc813c32b28ce9128208c6332905bcc9a96"
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
