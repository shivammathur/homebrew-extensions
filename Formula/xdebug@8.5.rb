# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/2d01ef1408eb8e350a3fef78b3db6d3da10c8620.tar.gz"
  sha256 "3190274887a9a5ca9ba3141d7adb1b6100ccabefee02bff395a395018a5ed9ed"
  version "3.4.5"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256                               arm64_sequoia: "7e5757ecbe7c6d6e58e624bbcb891a8a42814ac6ac0486a6aed549dfb22cd8d9"
    sha256                               arm64_sonoma:  "3cb7ac8e7322ceeceacc19c0398341d008acc3e8bec15f3c085c53fedaa4e8eb"
    sha256                               arm64_ventura: "3807722f7580a543333cbc49f6da2c7bdfd78d4dde761ccf5d10a1e64501f88b"
    sha256 cellar: :any_skip_relocation, ventura:       "d5e2ee4277eb4c721d8d3f539070d65fbbaed9813d0b9b060aa0d3033c2e8712"
    sha256                               arm64_linux:   "d76d367fd3d382805b3e85db631052ad91dd53959a7c8fe9d452db00b1b16caf"
    sha256                               x86_64_linux:  "f44f5304b0f66d2958b5b59583010d4d3880103f48c55ac5cad364f1d8e67f8e"
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
