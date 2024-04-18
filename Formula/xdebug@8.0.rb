# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.3.2.tar.gz"
  sha256 "9d2001cb8c4d5a2f6302e1bb303595a01c0337dd4e0776b05e8abcb526020743"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sonoma:   "80b467aaffd4d446ebc9720b82a71b88faf255165839403f76f46cfaf47a6b2b"
    sha256 arm64_ventura:  "5acb381ab70c1bc5d33a157be60dd14833146d0cb75c962cb40d045b773408d3"
    sha256 arm64_monterey: "cbfc74310d5b9bd151a7d5878c0187cab3cc436db54ff6118e55f4f048126c1d"
    sha256 ventura:        "10ba4619c69a71883c2e454e97aa270442caf760a439fef79115fb97f4c18329"
    sha256 monterey:       "af6b14d2ef5cc5221c377ed1e72682dfe66c0de2102a63f09f75885e2e5213bb"
    sha256 x86_64_linux:   "c3d53c51bb3ecc48be24c8cb8ba4408d8d0f0c1dd540cf9b062e5d34d454099b"
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
