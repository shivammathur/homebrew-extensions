# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Lua Extension
class LuaAT74 < AbstractPhpExtension
  init
  desc "Lua PHP extension"
  homepage "https://github.com/laruence/php-lua"
  url "https://pecl.php.net/get/lua-2.0.7.tgz"
  sha256 "86545e1e09b79e3693dd93f2a5a8f15ea161b5a1928f315c7a27107744ee8772"
  head "https://github.com/laruence/php-lua.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/lua/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "0c39ebf8e75c77c1c8697a7fd3f247e96586b27387e93e6d416a02b96312b14c"
    sha256 cellar: :any,                 arm64_ventura:  "3e50b2b2a6e184251e211e746824909de2a1e77c85bd2c31540791683c3a584e"
    sha256 cellar: :any,                 arm64_monterey: "18ec385a148ee0681eb1a46a4ed3a5e55a7fe77e058988ee812502f9892fb20b"
    sha256 cellar: :any,                 arm64_big_sur:  "f0a10cc38d1cd94c0111819ca65e5ff734f65ea2a12adfa8faedfba0c0700ee3"
    sha256 cellar: :any,                 ventura:        "a3213ff8d9597425433d9675c44fc5dcf5d733666801a7bf306984adef25ee28"
    sha256 cellar: :any,                 monterey:       "abe21381aa9c684ea9c11282347a68b6ab293d4885d2d83beb465e0996c3560c"
    sha256 cellar: :any,                 big_sur:        "73473f2f0c4cb8fbd1ffe68f8da27bce6c7245b067d7be8ae7489ad2e073d7d1"
    sha256 cellar: :any,                 catalina:       "44667b40b7e49bcd6dc90e57f836d0798f44de6d308357805eeb7e7e9388eb37"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4296828b357673f11337c8c1d08db6b18f757eebeb7bf0447e5d256ada9418f1"
  end

  depends_on "lua"

  def install
    args = %W[
      --with-lua=#{Formula["lua"].opt_prefix}
    ]
    Dir.chdir "lua-#{version}"
    inreplace "config.m4", "include/lua.h", "include/lua/lua.h"
    inreplace "php_lua.h", "include \"l", "include \"lua/l"
    inreplace "lua_closure.c", "include \"l", "include \"lua/l"
    inreplace "lua_closure.c", "lua/lua_closure.h", "lua_closure.h"
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
