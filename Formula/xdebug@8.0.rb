# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.3.tar.gz"
  sha256 "6620bf33db616ba52cc6b5976265d8962d8d23321ad5fd63b862c8d47eb5152f"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "4431adea635e6a9be0a22e8fc3957495a6274a5e0836da1694336b2f311a87c2"
    sha256 big_sur:       "0d959742307490e668213b84ed4862504f4b1cf285b4a562fd1f0ac4dc20f476"
    sha256 catalina:      "2033c09c7d3af31b74687c89df505ea02f950c1a4d7677f9dcc1421f33df50cc"
    sha256 x86_64_linux:  "775120ce02deb2fef5f4d98fc3e474d2b7373c703f86d4db2b2ba6deb3a72fc0"
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
