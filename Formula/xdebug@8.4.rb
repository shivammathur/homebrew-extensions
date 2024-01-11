# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/6647902aad7a2434d4ef5a5dbc667272322413a6.tar.gz"
  sha256 "610afd6a70e4179c4fd492b269fba9d7f92ca5a69ae313ec313f3d05a58c3755"
  version "3.3.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 arm64_sonoma:   "2622cd61dc790be9a74691012fbfb4a6686262962e44048c6577a6c6ed766c97"
    sha256 arm64_ventura:  "6263c28eb2da68a040a5cd7b9e64b76ba08353dee187eb9467d83bee795ef80d"
    sha256 arm64_monterey: "0d998c402b4bed0b4c5e56f947dac9e00f94054b7da96aae17f86f3f19c16f38"
    sha256 ventura:        "9bcb9d4fcd01a392042e0caa3e3bba41b64f76793d01a19cf4bc04dc213c04cb"
    sha256 monterey:       "240fe432ffb0cc88dbf5f69a95d9969e6573fe872ff525b4d7a841714d4b4bbe"
    sha256 x86_64_linux:   "b0eb31f5cf537864dba1b0ca88bbc0ddfc9bd1d35f2d86ec70cccb87d0b60202"
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
