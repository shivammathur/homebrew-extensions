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
  revision 2
  head "https://github.com/laruence/php-lua.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/lua/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "d98b02799c788b1c44db05bc13db7d8e58a54189cee24fb24d4e2ec043ed5b82"
    sha256 cellar: :any, arm64_tahoe:       "07d7747cbb97bd22ea8efc7b2832f2d04d6bb153fcc41e7cb30ba8a2246cdb2f"
    sha256 cellar: :any, arm64_sequoia:     "5c637cf6ed1c4bf4bdd34c8a8588e7c2e32558f969d69b6f7aa757be22effc27"
    sha256 cellar: :any, arm64_linux:       "9a40682306cc0289a0fe68b9bf4875c844b5343e3d0583d6230092f787e18495"
    sha256 cellar: :any, x86_64_linux:      "f2985e8d63fed23f6ba7bf01a8f336927f7bfac33ff95ff603766cd2b982c58b"
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
