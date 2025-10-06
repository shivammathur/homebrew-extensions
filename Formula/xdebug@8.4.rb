# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.6.tar.gz"
  sha256 "4ac1a0032cc2a373e4634ec8123fc6e1648ca615c457164c68c1a8daf47f4bcc"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "c9e70902c60ad47bc18f286563cf18525ceb9d397b9c9ccdbd3766ec9bf33577"
    sha256 arm64_sonoma:  "e938aeb1229492f63a9ecbc889414f2ded050c809ad82f270f94249caacb4346"
    sha256 arm64_ventura: "100d4377d2d5420d4cdc5d419147694752a60bdec15387883ca3b1124feaa910"
    sha256 ventura:       "e6a028aa2b5feaaad579ea5cda8e641801fc1b3dd22e0ee22865f8db38e3fc80"
    sha256 arm64_linux:   "afd212d96f35b93180935985f28e67e111bfc537cb284e8fcc5761f3901893d4"
    sha256 x86_64_linux:  "ab83153ea89339867885a1577335e8b043266d7ee584fd091c1e702bf76f14cc"
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
