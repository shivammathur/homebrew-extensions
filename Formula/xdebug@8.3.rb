# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT83 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.2.tar.gz"
  sha256 "505b7b3bf5f47d1b72d18f064a8becb6854b8574195ca472e6f8da00bdc951a8"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_monterey: "fc61a73a3a2fc68125686275df188f2a72f84bb190345f9d71525fd8b0140e96"
    sha256 arm64_big_sur:  "57e46cfcda32dcbc42d22ddbcdb19d71627fcfd1484f78765524e1b26c1a8a23"
    sha256 ventura:        "565e8d77ff35271f47e20eddfbd6ec89a126e93e683d0f00d198543b3ba7b10f"
    sha256 monterey:       "83789bd0d878bf0e3723fcf36efcb8b58322cef1faf9c5d8c8355a7ac075ea44"
    sha256 big_sur:        "bbd97e66b15b0702e4a15cd9654f40650c4c7c0262ca7164382ac2e30b679f81"
    sha256 x86_64_linux:   "c2e051d18bee46350bce071c7d01e38f5f3ca5cac195a41701044d21e0a1ecab"
  end

  uses_from_macos "zlib"

  def install
    inreplace "config.m4", "80300", "80400"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
