# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/master.tar.gz"
  sha256 "3d8777da27bca3a20dab3e4d7372ce8b974de53f87898f622389e5da3bad334f"
  version "3.2.2"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "d57d9f0baa2c3c4f15958e625fa913fade180fa871bffd5b2574244a43f083db"
    sha256 arm64_big_sur:  "40b6daa415623b7a03a3ca1cf1a0d880eab7b3001734c9890dd8bca582be48ab"
    sha256 ventura:        "a886eb4d80d1575b027b270517b1c0e174b9ec256c3cb5d4786a18894571d870"
    sha256 monterey:       "2442d0544fa4fc22b28bd2dbd66225fb542f6f60fb97929bcab99508d0235ff5"
    sha256 big_sur:        "2d6efa0fab82210eea33c3063fa9b3fac2503ba67e8364149dad4262221b0a8a"
    sha256 x86_64_linux:   "eeb5804f6c7aa125f194636757c48ce788b5f05ec8c3a623c34a9d72830efa7c"
  end

  uses_from_macos "zlib"

  def install
    inreplace "config.m4", "80400", "80500"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
