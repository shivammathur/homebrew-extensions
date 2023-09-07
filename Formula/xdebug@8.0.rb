# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.3.0.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "79e2fde5b5b857b562c8139310476780ba7392a0dfcd13f2f83275318f54e029"
    sha256 arm64_big_sur:  "7b19e68ab12fc97c98e7c899e99d014372b40f55afef1aa3cb79d79693b8cfaa"
    sha256 ventura:        "89e2f7357c57fa3990640e173b73103dc75275915a93854df6654cfb72fb35e6"
    sha256 monterey:       "5bc04ab261d0d7a2a12c3e6e1ba77f7c3459928bbcccccd008f9f719f70bb656"
    sha256 big_sur:        "45fae1f559fafb9178b68d1416bd55e4fef539d6a2ad39d7d123a84f409544b1"
    sha256 x86_64_linux:   "e273b0431d0452f410d64a556e411e4bec582df27174117fad015e151da18f28"
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
