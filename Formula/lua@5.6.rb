# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Lua Extension
class LuaAT56 < AbstractPhpExtension
  init
  desc "Lua PHP extension"
  homepage "https://github.com/laruence/php-lua"
  url "https://pecl.php.net/get/lua-1.1.0.tgz"
  sha256 "f063fb8e8ba5cfe5e120d179b84db77ea3344ce08288b48864ccb883a9826554"
  head "https://github.com/laruence/php-lua.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "5320cb7208ab85b23cba2da4c730db059b0d621672374c10f4adabbf04d9ce5c"
    sha256 cellar: :any,                 arm64_ventura:  "04470edc76c940ec04b38f028dc585b086deed3ffd4f5c850902a07d89d8ed4d"
    sha256 cellar: :any,                 arm64_monterey: "8f910842ebe83c5888c9cd7d5a83e2ae494c6714cf09c1e9a6b3446d33a3c49f"
    sha256 cellar: :any,                 arm64_big_sur:  "13bbc6bfd1d8f375356a9580f2f1863406d5a895b1f48fea4bce23a7128c69a4"
    sha256 cellar: :any,                 sonoma:         "c74c1319b1868ff69249b893ebf22d18f9aa9c7b5d347a67203a394a4ccad839"
    sha256 cellar: :any,                 ventura:        "5bd16f180d715479931cc60ae94490aca8c1eb6e3f950624d80b571b4bdc770a"
    sha256 cellar: :any,                 monterey:       "747231da3701488fbfd2c76b677ef844cd8d27ece5f74911b7a06ffcd9919901"
    sha256 cellar: :any,                 big_sur:        "e6486c2994e03dd53572424d0d3491107181dbdce6e4ee3346c970b4ca00844d"
    sha256 cellar: :any,                 catalina:       "2570c15eeae41baebb14b3c3440b9e05711fe945532b3b1ef9ac76d0bec20114"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "8b899b575214dba11a52a93529bb2e8ab6d7beeb67b7bdc4726489ed64cef02f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "de4073a01b0276adcc44d1a774ea8bd8b8b5345920541de6df00e327742abb53"
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
    inreplace "lua.c", /.*LUA_ERRGCMM.*/, ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
