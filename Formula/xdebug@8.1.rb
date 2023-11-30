# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.3.0.tar.gz"
  sha256 "cfb5af5a1d8d96ca133d65f9d2c84793ec66043083ecc3d3ee4569b3c27f29ce"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_ventura:  "17b02e6e2e7abdec56821c2c43ab0bd3f732d38bf9104532a2e502c66041633a"
    sha256 arm64_monterey: "1b2af7c38d0a0d6650e0729c96f3aa7cb3a2c630c2b3cc2185b29a3531f2acac"
    sha256 arm64_big_sur:  "36dd3416c2f5e58131c473eefcb410b95474562d36514c6b790187a0160e9e45"
    sha256 ventura:        "cb8724b962aa602bd7e8a1fa9923f267240ba6369c71d870c88089679207ce74"
    sha256 monterey:       "121fd1d6a67b0a2d84d78068a58c86c4777084a15d11d7028629cad01bb1caac"
    sha256 big_sur:        "c7a845667066c53069937297e40fce4b5bef81c152f7fa75c07a3198c4de5905"
    sha256 x86_64_linux:   "f25386afa8295d30d59ec4b57d16687eb6dda0b77649139f1114a7df54ec5b59"
  end

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
