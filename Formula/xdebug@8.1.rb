# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.0.tar.gz"
  sha256 "ea3a066a17910ab9be6825cb94e61bb99c62d9104e2751f15423d2b7903bafdb"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia:  "ec29e2a69557923a7dfc6c3b4a08682a27809046371faf63b597ea97d94af215"
    sha256 arm64_sonoma:   "52ec2968b1e11ea57dc92e9414a200bbd380aa8923f9263105a0255bcaf54dd2"
    sha256 arm64_ventura:  "59bf8a4d2540116865b1476a50ffadafd43648f6b8bcc4b219d38699f5614872"
    sha256 arm64_monterey: "3fdda4f53fd3c9e3c0edda9b5007cf03b024eb2eae5f2a0de560bfca465c4274"
    sha256 ventura:        "123f90e6a943d7e6def76cc415bc5d74a957014f2b99576f9dae057109221fed"
    sha256 monterey:       "179092ba06b76144fe382e883caa10b52d2e7b00be2fe7f21196dc79c744c277"
    sha256 x86_64_linux:   "0d4ea62e683bb68c9d3847266f29acb6fd4092c52294d33fc8eea9a0264e4310"
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
