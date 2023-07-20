# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.2.tar.gz"
  sha256 "505b7b3bf5f47d1b72d18f064a8becb6854b8574195ca472e6f8da00bdc951a8"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "8a4eb51c59db409613e18d7c6b3d83edaffd9f4006f8445facf1e34a23323650"
    sha256 arm64_big_sur:  "92dfebb40525d23cabb2b9ceacac8b2b8bbd9e567d283c3ee540e81eb36ac7c8"
    sha256 ventura:        "6ddfefcef426d3c67cf85790d6ad9e618bdeaad64fff7bdfccfe414f52dcbe04"
    sha256 monterey:       "e87bd5b171e31b2638f06adb39a712352e2ca1d7b22375fa4043df12fd800c63"
    sha256 big_sur:        "7213095e17717591b3f56a7e25a94d3f5f108b1e3f71302f9f3e9eb2f97c3e8f"
    sha256 x86_64_linux:   "7d941e3dc250d6c58069d5148b02b946694db87a1700a39a62a20792201e6ffc"
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
