# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  version "3.3.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 arm64_sonoma:   "d5f37dd2fb0e39bf59196c19a2b00e10dac46bdcc86e29bf151c756240bc4641"
    sha256 arm64_ventura:  "068f5c76f7151895fc018b3515ea5985a0e49d20bf1e9783603fa75df6ea6cae"
    sha256 arm64_monterey: "c89191be9e6a5e506e55fa13dd481ab1275e43ef1b2e07924a70179b72ce0cef"
    sha256 ventura:        "5fc615391b1c7d8f15f39b0f2052ced5f34c394a44665b4938474366a71872a8"
    sha256 monterey:       "222146eb7a8181ef85cc849ab620ac9c021228093943e52ff224ef660604d709"
    sha256 x86_64_linux:   "d87a3db190a23340b4930ced6db9d3a06fc6283a63ce555c358707b03bf9c0af"
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
