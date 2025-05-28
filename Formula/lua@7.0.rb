# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Lua Extension
class LuaAT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "f10aada869338295bb289833d5e2996c21eece0d48a81c216fe6b31abe0a9645"
    sha256 cellar: :any,                 arm64_ventura:  "41ef39d0c9b8e30e917a25ee951940121a23433e91b20552ffc4c6dff093c258"
    sha256 cellar: :any,                 arm64_monterey: "896a97116def86575598f11f011cf0d5fe433f35c0652bcaf420ed3cfc6cf1ab"
    sha256 cellar: :any,                 arm64_big_sur:  "a55a4f60a65039eae979b0d1b757801f7b96f39a490a4538972c91fc9b155237"
    sha256 cellar: :any,                 ventura:        "571fe7e80cbab4a62c2feba0eef085c685f951f829e35e7ddd65a968939f8627"
    sha256 cellar: :any,                 monterey:       "a611e4ba0838f6e08acf050d828b5247dddcc9238edfc7207802d5665c40d981"
    sha256 cellar: :any,                 big_sur:        "a4c87835ddb7888e72a3df901af87c448716f048a0b439eb6981b49c0ead1152"
    sha256 cellar: :any,                 catalina:       "fc7c4fcf04ab9e1e6078dd3fdaca553edbd9010eb1f2d717e171ff491cd8c2b2"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "9944e602d0abe536034c632a9fc52e56fde6c93deec51bd64259874ea58353a7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "48b69a4c405742b9f5b018167032870d282853dfc15f6c2b3f331076f44f6c02"
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
