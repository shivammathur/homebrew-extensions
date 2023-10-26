# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/8e5c25f194fa200070b4fc45a14cb5f48dc97fee.tar.gz"
  sha256 "b202f884fe7f54d4c751030a2880418b13cca2fb4fe76ca77cd85a15f4811547"
  version "3.2.2"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 arm64_sonoma:   "19ee325e6ab7c0b1517146494d4a7d370fbcdfcf32827d226c5af5f901c1655f"
    sha256 arm64_ventura:  "9b866bd92dce55b6005b585381d73245a48cab8fcf4f734ab917c2685fa136eb"
    sha256 arm64_monterey: "f90c9c472286d4cdbfbbe5e076eacc3b4f534e0cc8d736245abc2fee1c86926a"
    sha256 ventura:        "9f241d6711a82403b0c6d38bb49d380348f17569702c4c91b74df2581725d98d"
    sha256 monterey:       "67cb6d0e82b6a72642f37696c4f39249d913681cd45ee728410c4f63be74fcff"
    sha256 x86_64_linux:   "d38f57357be04dafb88308558105a3fbbb53f8d6895e837cec24c5a1091c3e45"
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
