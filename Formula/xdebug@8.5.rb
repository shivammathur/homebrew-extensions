# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/cff20f94f51cfc50c3aed9df27a6991017765560.tar.gz"
  sha256 "64adeab0e98107ad7015ed5e82171b006f2bb3973a7558fc7176b21256b7f242"
  version "3.4.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 arm64_sequoia: "90d4296842e09b7d46762c1ef32d314b7f69dd0552c0fe7cadc00f64c48f3cf1"
    sha256 arm64_sonoma:  "cbd8659babc1d35769db4c14cf740f62d4b88273dc7420bf2c75a77c6ccf3aa7"
    sha256 arm64_ventura: "557bcb06db68d7b905d1451e1b2ac4c2760114ccb92886ca5b7a6eecc5856877"
    sha256 ventura:       "06bc8f739696ca5aca4c4f9a6e7f594982296497586623f49b8d6c928bad04f6"
    sha256 x86_64_linux:  "26721ffec6be611f2e02faeb0d41a490e67aca8fc3ed32dc544b6d94c1896bc3"
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
