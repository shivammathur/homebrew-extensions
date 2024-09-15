# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Lua Extension
class LuaAT72 < AbstractPhpExtension
  init
  desc "Lua PHP extension"
  homepage "https://github.com/laruence/php-lua"
  url "https://pecl.php.net/get/lua-2.0.7.tgz"
  sha256 "86545e1e09b79e3693dd93f2a5a8f15ea161b5a1928f315c7a27107744ee8772"
  head "https://github.com/laruence/php-lua.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "8075602592fea39fd56b67f88168f2ae048dd19fe5d8e9af82464bf905303fcf"
    sha256 cellar: :any,                 arm64_ventura:  "17018d6b760702687a9677913388d0013f308aeff5f7bdf708b98c1bcc785ea4"
    sha256 cellar: :any,                 arm64_monterey: "a3d2669a9cff387d8a82daeeb51caced84b76e322e86208b5945906bb319dc36"
    sha256 cellar: :any,                 arm64_big_sur:  "4a3ee5f70f4d3405073d5d5e70416c59f125821de4a9dc8adcd04917ee84ba7a"
    sha256 cellar: :any,                 ventura:        "185b191335656cbdc2e4fe3ab7dfc0efde86b3139638a29e8925f7d21c48c957"
    sha256 cellar: :any,                 monterey:       "709fa4876039ec3a9bfa786fc84c7cb6ddc6a9d1f76bd87178d64d4db631e1e7"
    sha256 cellar: :any,                 big_sur:        "b1a07d7300e3e79ace0cc4cb6c149321396fb87b407f824d05e180db0056a3bc"
    sha256 cellar: :any,                 catalina:       "5f414399366951746b66ac049af76f4ecb2f707d02e46d9c3ca2a27dd2dbbc13"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "80eb33e76cd7957ce6180c90d4cf12a1d2e40563392ff4376606ee92f811cca5"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
