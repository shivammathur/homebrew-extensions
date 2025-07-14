# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.5.tar.gz"
  sha256 "30a1dcfd2e1e40af5f6166028a1e476a311c899cbeeb84cb22ec6185b946ed70"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "38c96b263d7ff041450f6bfb5642c41273a0a95dfab10bcd084983abc2ba6291"
    sha256 arm64_sonoma:  "482d82b9590eb65388dc69c8507912275e04fa6c16f484756ac2546d0b34fd59"
    sha256 arm64_ventura: "80057084f1d0dac6771e21a4f0737a1d26be1e26ee5cfd736b6fa72e97628349"
    sha256 ventura:       "30af63c4cb720636e8a00e368b0932b224dbaa929a56a2680472f2c258f8b719"
    sha256 arm64_linux:   "06d0781ecbaf0f1b03e494757fb0b7a52c4e49f6ab976382af9947a2a579e537"
    sha256 x86_64_linux:  "6d815cf7109c5eddec8d06a0dda5afc588175aa0a0f6fc8be1cb559c54302299"
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
