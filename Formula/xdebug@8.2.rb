# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.0alpha2.tar.gz"
  sha256 "3db2ca7b20830b790e3a4ddca93a0cbc12bc768beeb50b930c9cfc0b4874846e"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "4d7a1e651f4a6d9608c210a67f35a56c7330849b18d9ee2b5090091e0863259e"
    sha256 arm64_big_sur:  "4376000cd723682cf60151af29b62b5e89bebbf2dde461b17e250c364f78e749"
    sha256 monterey:       "893d0a7a99a454606dace58a3ab63d038eccdd5ea518d08ea0028f0bc30f59ac"
    sha256 big_sur:        "ac68f62aa9a273115059193033b6e25a61d286e926bcdbadff5a83d9b34dd124"
    sha256 catalina:       "287240824b785f70b11325b597646d31d27a82e4ed987601a7cf42f9f3630d99"
    sha256 x86_64_linux:   "fe06aafbd798853503a6e7b9fc7631d0342a05e5be0ef185a77b3ff0af5d6dcf"
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
