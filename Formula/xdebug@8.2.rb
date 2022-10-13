# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.0RC1.tar.gz"
  sha256 "7f09508095b04600655db8faac08b7a58121a64ab3ecad018d051dcf44f7cab0"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "72d0413f78c20fdd7b76e89dc4549ae31af161059d3c006b803765c2285f8f4f"
    sha256 arm64_big_sur:  "d7de8f957fb56b7bd9cc36eb2d284b9e221021d573eb2d967061284423ab79a3"
    sha256 monterey:       "044f5eeb370a681c6689c8190f2511b642f324f209b38c0d23d48074b00e4e11"
    sha256 big_sur:        "04586425f87fd4ae6cf0aa6eb7e69732b08066889c963ef8f5f98b2079bc5d83"
    sha256 catalina:       "522ed8069201016d4e8051696cf3449059d65f6c45bc182b1fc697d95c9f6a1c"
    sha256 x86_64_linux:   "aac6844a67603d63382560c84d42d70306457eb0726c29d87b24fa3ccd2f0fe6"
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
