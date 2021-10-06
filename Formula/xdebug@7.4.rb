# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT74 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.1.0.tar.gz"
  sha256 "0a023d9847a60bb0aff9509d92457e9c0077942d09e8bedb8e97bd3b90abd7a0"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "8ae5aa1c2de3d0e1af33b339978ecfce9ff71222743b65c7b3f16e06caccdc4a"
    sha256 big_sur:       "3354d685dd057fe010b866abe45560d3122328397b10f59c30c0d2cd98110bb8"
    sha256 catalina:      "e17b0bdef29bd9877d600e3a4bd76eb81bf664907c7200cc956e00e6b04c97f0"
    sha256 x86_64_linux:  "2a82655032b88eb71820518394d1e63998cd79679945149d7e141406bca43c69"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
