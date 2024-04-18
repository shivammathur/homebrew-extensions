# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT83 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.3.2.tar.gz"
  sha256 "9d2001cb8c4d5a2f6302e1bb303595a01c0337dd4e0776b05e8abcb526020743"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sonoma:   "a10ca69ad7fc83fabd2314fdef0183107f906d8f1fcf92e01a006cb11b811734"
    sha256 arm64_ventura:  "5445433dbc330d463bc2750d334a1387849dd99979433075002612ae831bf0b7"
    sha256 arm64_monterey: "dc052c21e9644b0ad6bb29b2c6bf39045a8a2bc2a28093f098445976f2730015"
    sha256 ventura:        "f50da48d5883d499b0217f94102f618596ee912705bec26c8a5ef74cf7361980"
    sha256 monterey:       "751b3ed14981116a32c1e2300cb513b08a6b36acb6da06750eb31963d74baab8"
    sha256 x86_64_linux:   "0edba243d545a00f701090d164b6a5c86b5fbde524fab0e11e584f5f65eed9c3"
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
