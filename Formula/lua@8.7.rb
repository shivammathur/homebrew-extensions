# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Lua Extension
class LuaAT87 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "aa25f57647914b79a27d9965240265e4558bcd3b8b8513c9aa33e9b9650d18e6"
    sha256 cellar: :any, arm64_tahoe:       "8c0b0c165eb703ae10110a41889a47e22a003990456b84b735b154a9c6c2a5a0"
    sha256 cellar: :any, arm64_sequoia:     "25dba4d4def253ab7ee94b8636cad769a9729cebf819841487a003f7f07ec924"
    sha256 cellar: :any, arm64_linux:       "131a1c1562536f11207b879e7eef72508a53a628f6b84e6daaa265663a289b51"
    sha256 cellar: :any, x86_64_linux:      "30a97dabc8431326d7a338508aa3460eea95354009700b894efa593dfdc76b6f"
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
