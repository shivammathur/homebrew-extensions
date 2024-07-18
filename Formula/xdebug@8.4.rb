# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/81a312d956ce29258b8c26d1fdc9d666b942c8d9.tar.gz"
  sha256 "db183091907e4bc9988c0b9d9319074cb5e077e4d55e77903b0f97c85d29b025"
  version "3.3.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 16
    sha256 arm64_sonoma:   "75bf28685206745c6a74f8af6dbeff5c6d3d8d7d920c35722bdd45985d7d2bed"
    sha256 arm64_ventura:  "328c8e54c85c71575463c5646a8fed2fb22efd524c5211417621f5b2ecbcacfd"
    sha256 arm64_monterey: "d231accbfc9a5fd9a340998f933b5a2c3aad4c625c5006f35aeea6345fb2aa92"
    sha256 ventura:        "064bd5b03b5f22b14460c9d3aaed7322755068312fbc25e04f792aef247c03e3"
    sha256 monterey:       "fd63217badab9653467a8300acc8c0995053ccd077a82cd4a1f661dd47424915"
    sha256 x86_64_linux:   "07ae88f6b2acad5ac429a499ac3299e36a97004b392da9022033169c0b2f438c"
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
