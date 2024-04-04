# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/ee60cd694186ce1c0f5f52b46d72dc8fc694859f.tar.gz"
  sha256 "efd6eb49b29a3d7d2915b2f319e739a4d9bca324369fdbabfdcecbdbc7c9544d"
  version "3.3.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 arm64_sonoma:   "8a9dbccfa7c5f23e3aaf1519f83c462884c99fd76812294c978f960cc846847d"
    sha256 arm64_ventura:  "76534d5fddfa95b8ff100a89e51b249e39b4b516d57f3b092e9b5b187eb47a92"
    sha256 arm64_monterey: "d77184f1f2fdeb24e2ac4fdb1007c7a947824167ffc6eea23c5f58a545f14492"
    sha256 ventura:        "fa0a4dd69d315d6c48eb4287b875c6d974c8d96e670089f3dc445f1341da91d4"
    sha256 monterey:       "4d9b961e6b7aa722d48f2a36786c06130345638b1afc2e5415f854dc3ebd29b8"
    sha256 x86_64_linux:   "760a16395e9e9cd75dbbe43840e9d2ee980fa5d6325256e6e849e5052ef4bc85"
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
