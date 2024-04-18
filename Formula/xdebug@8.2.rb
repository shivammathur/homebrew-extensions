# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.3.2.tar.gz"
  sha256 "9d2001cb8c4d5a2f6302e1bb303595a01c0337dd4e0776b05e8abcb526020743"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sonoma:   "537e20491d578a629db243673dee424746d3ff1a8a4e813a86c08314dbba2d67"
    sha256 arm64_ventura:  "41e93adae9629259e3b2bfe57d28d80cc01012ae4530d1465b30801b2b7d253b"
    sha256 arm64_monterey: "ff3eb5d47e4efa4e7354c8d3c20cf05e6f7a741a5d9c94773a57fa8294e9a314"
    sha256 ventura:        "0506b1ef6a1e5d07f6ccee89d3564fe9368def6df08a000d0def7d3c54f59b42"
    sha256 monterey:       "064403a5528551d45a1a58fa688af46e94127e7454be2c84716a71a36e0cd156"
    sha256 x86_64_linux:   "0ae8f5226f0103bb8d1405d5440300d0120970fe3dc5da2543e88545a7957ded"
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
