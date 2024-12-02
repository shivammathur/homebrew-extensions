# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT83 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.0.tar.gz"
  sha256 "ea3a066a17910ab9be6825cb94e61bb99c62d9104e2751f15423d2b7903bafdb"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "418f81db3ac194026c9e48604e7c4c3ad42dcddfeeb4cac18c53893e27deaa17"
    sha256 arm64_sonoma:  "e25a27dd792fd7379085a823f56b7d539a87c7ce488e65d7f255bd172a5f2bf2"
    sha256 arm64_ventura: "f2cd0561dcded39da1474b0bc730c73681c3a5036bb1c1ee9a4a92515841a21d"
    sha256 ventura:       "be2e2bbe96b12f60b6491f7bad0cf8fd4735f08b471c64b1511403ad9a0e7cb5"
    sha256 x86_64_linux:  "9c31204df419fc550b202f05f66bf91747509faec31c741f2ee136b194ccb705"
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
