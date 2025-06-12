# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.4.tar.gz"
  sha256 "e906c231812ffd528f3dadf10070f469d82e392458a733a3e50dba7021e43034"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "b0c78908260e66983c386bfaa194e7a0d995fa62140b1a742d36acf2b9c5717e"
    sha256 arm64_sonoma:  "95218bd7537d5300681da8d9042b157005956027ac5de7e3b63d1f3042221b29"
    sha256 arm64_ventura: "94932b65bc1bdc05cbb92e3e539ef92292788da43750d9b30c38e2f028309ef2"
    sha256 ventura:       "8d1cdd611c15f7248306a860b6bdfbbc5a5b64f41bc842530129ff352e778c36"
    sha256 arm64_linux:   "63654e52e9ae010a6fb89fb21ae7c407a0a8b39a611a7907b085536ca524ea88"
    sha256 x86_64_linux:  "f4760e1808fac74f6d4f76128ee37a41a94e16c86b33764cf2d1722421060514"
  end

  uses_from_macos "zlib"

  def install
    inreplace "src/lib/usefulstuff.c", "ext/standard/php_lcg.h", "ext/random/php_random.h"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
