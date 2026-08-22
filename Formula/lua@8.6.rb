# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Lua Extension
class LuaAT86 < AbstractPhpExtension
  init
  desc "Lua PHP extension"
  homepage "https://github.com/laruence/php-lua"
  url "https://pecl.php.net/get/lua-2.0.7.tgz"
  sha256 "86545e1e09b79e3693dd93f2a5a8f15ea161b5a1928f315c7a27107744ee8772"
  head "https://github.com/laruence/php-lua.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/lua/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "468d5d0bb1044acd7bf221445d53f9e0368a31daa863a3ef8e8a25563c15006c"
    sha256 cellar: :any, arm64_sequoia: "957cda6c6ae4ea0465edb9a80b62a8ffab233cfc71c9a16d92761ae0d53dbcc5"
    sha256 cellar: :any, arm64_sonoma:  "e2fe8f742589692f9d4afdd0b977d137c3063e2f812c728850eec3b4bde197f5"
    sha256 cellar: :any, sonoma:        "2628a9fe1cae85056e4144ae839383e1a76cdd8e9b13c5ff30ff6bec1a1f5673"
    sha256 cellar: :any, arm64_linux:   "ce2b511da747d2892c7a5e64138452b96377b76fb0b26dd913c05ed6ce9acb08"
    sha256 cellar: :any, x86_64_linux:  "ba9a4f750c95c931889de0995b62cbb3099dfd464eed050f78a340ddfa89887a"
  end

  depends_on "lua"

  source_directory = "lua-#{stable.version}"

  patch do
    url "https://github.com/laruence/php-lua/commit/f7012e45faf6431e3c45bbfef683a6ec7180d86b.patch?full_index=1"
    sha256 "379d245a7580775734330c3c8806354a4f112f4151902ae887460af6d7596fb3"
    directory source_directory
  end

  patch do
    url "https://github.com/laruence/php-lua/commit/44a0c089cad09e823945adff45c84f29a1f115f5.patch?full_index=1"
    sha256 "34dbb9e24d9e582ea8f43ba72bdb842372aa450abd5cdc54bb68923df43f5885"
    directory source_directory
  end

  def install
    args = %W[
      --with-lua=#{Utils::Path.formula_opt_prefix("lua")}
    ]
    Dir.chdir "lua-#{version}"
    inreplace "config.m4", "include/lua.h", "include/lua/lua.h"
    inreplace "php_lua.h", "include \"l", "include \"lua/l"
    inreplace "lua_closure.c", "include \"l", "include \"lua/l"
    inreplace "lua_closure.c", "lua/lua_closure.h", "lua_closure.h"
    inreplace %w[php_lua.h lua.c lua_closure.c], "XtOffsetOf", "offsetof"
    inreplace "lua.c", "ZVAL_IS_NULL", "Z_ISNULL_P"
    inreplace "lua_closure.c", "zval_dtor", "zval_ptr_dtor_nogc"
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
