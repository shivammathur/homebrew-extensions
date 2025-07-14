# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.5.tar.gz"
  sha256 "30a1dcfd2e1e40af5f6166028a1e476a311c899cbeeb84cb22ec6185b946ed70"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "fcc78e2fff6b77405ad5e0821b45d009b6c33fd20fb8893d70edc4c41e858be0"
    sha256 arm64_sonoma:  "8d210811f19e13fb1f06ac0d97a368a64406621193d4f92acbf5ffe088f79218"
    sha256 arm64_ventura: "0b9b84f40049789dcf39f6b30f341ee13bd2d6de50c0c60e7e50b94bed49b5ba"
    sha256 ventura:       "1cfb328038fb6af6f52aed030ae55d98a27cd077b909d74a19769a06ef240b98"
    sha256 arm64_linux:   "80107a35c83d7540a8b374c6b631d9b143d515c8035db8716c9ac08457083fa4"
    sha256 x86_64_linux:  "7ea4becad24c19812de0ae3af47df47ab926830a94a686cdd3e25a9c665e0853"
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
