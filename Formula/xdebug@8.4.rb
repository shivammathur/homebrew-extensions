# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.3.0.tar.gz"
  sha256 "cfb5af5a1d8d96ca133d65f9d2c84793ec66043083ecc3d3ee4569b3c27f29ce"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sonoma:   "d3749475c12cc25782e76a6fe3ae44a9d8b7115e4660f5c6fc24a1367124af83"
    sha256 arm64_ventura:  "ae179259e560e3fa487a312dd659d112b2aed234180d9c15085e67ead4fb38ec"
    sha256 arm64_monterey: "e2bf850c603d99e79ade4a897aa829a5581d7f53712d1593e3974052fab12aa7"
    sha256 ventura:        "b81d5c56c66b7c059243b9aeeb25e23449b1aef52caa961ddf37c41b59b5f8ee"
    sha256 monterey:       "316e021167c7384adb91ec083736957b0291c3f7144a7d0d1d393f260a124ec4"
    sha256 x86_64_linux:   "3d5a38104cae2322d3517dbdff170b3cdd8463046e49dacf19fde5e53c80a421"
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
