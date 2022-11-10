# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT73 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.6.tar.gz"
  sha256 "217e05fbe43940fcbfe18e8f15e3e8ded7dd35926b0bee916782d0fffe8dcc53"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "17918bf302dc908dc483ec4f3530a5a7c1a62fe372be53a9c541f7a76285ab6c"
    sha256 arm64_big_sur:  "e035af493750c3138054dce7ac4e637b51d223e704b825c0dafc9b2e9f662712"
    sha256 monterey:       "9e24d4559bc36a031cf5517676bd518c46ff77983affeebfb1d2bba32bca394e"
    sha256 big_sur:        "0b84176a5eca33a326c71b97e0d3d7f529f031e96b7891fd5fcb699d77f9726c"
    sha256 catalina:       "fd08a7ed7e6cea67dae9484904544a027262a03050f20a13effe97d74996446c"
    sha256 x86_64_linux:   "f636174291554905cd0624cf0cb05db13e58c32fa2745ddb76cfb387096f75d3"
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
