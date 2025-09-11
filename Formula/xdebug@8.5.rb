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
    rebuild 3
    sha256                               arm64_sequoia: "0e1b8e31dbd4ce41d400d852993a2b18bb74eea484257cfd7073dbae38907414"
    sha256                               arm64_sonoma:  "7c27ec994faf293b4f062519b79016d4af7cae9032a70590f2e1753b0c6b2e43"
    sha256                               arm64_ventura: "9b44a3757f5e60a8003f6329a405df353a4b57bbcfb9ed49ffffd59469300eda"
    sha256 cellar: :any_skip_relocation, ventura:       "25571f0a196baed991618ca943c4729c4072ab10953ad5274dbaf3b6d0ea73ed"
    sha256                               arm64_linux:   "a8a069052799ba94fab47a5d088b31f300c36176a226aa6a27766d63ea08a879"
    sha256                               x86_64_linux:  "2bfb6ac9f29bd2c0c55a23432e7c74c6a5e15fae5bffecede0bce7c31bbcb768"
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
