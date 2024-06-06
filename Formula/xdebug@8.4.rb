# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/a19ea5931135e08dcee52a600bf5bf36e6cce1d6.tar.gz"
  sha256 "49289716bb8e327c5b8b27704d2e135373358a62b21ae500104e76ee821daa41"
  version "3.3.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 arm64_sonoma:   "00fc4f92791f751ed23fc369f0089695eb95f3c57fdbe907b8b16818a4bc7704"
    sha256 arm64_ventura:  "9ba71085c1b29c0ae0bd73be2aa2d271440c5b9aec2f2b17a3c431b715ff4133"
    sha256 arm64_monterey: "98e99064013749108ddd7d037e8d398260c5dcafa919567cddcdd0be08725071"
    sha256 ventura:        "b015852449a893eb885d8c7b9f5faa20344ea0394f2ed1967433b2f40b1d8830"
    sha256 monterey:       "60193fd5545d2a4d39bd51202d2b13a166966938022aca98579f2d897aa9e6bf"
    sha256 x86_64_linux:   "26c14cf228871ffd86f0f4d9fae7ef8a440a4f09dcf174c43f4165f18a3d5733"
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
