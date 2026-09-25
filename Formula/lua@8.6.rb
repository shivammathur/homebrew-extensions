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
  revision 1
  head "https://github.com/laruence/php-lua.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/lua/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "5c65d083aad99199eae57e04d9c1dc20891eb4edb8bf2f13e37360e58896d9d3"
    sha256 cellar: :any, arm64_tahoe:       "e3ad5a90549774f6d8534c68e114f17a30d3843646802e16099d21a6b7810c09"
    sha256 cellar: :any, arm64_sequoia:     "401bce306afc60b42d9503d8317e771402bccf5548b60df8044a73983711bbef"
    sha256 cellar: :any, arm64_linux:       "f253245b8f29561656976b212411d4318b1490393d2f422441c597ee08c7c725"
    sha256 cellar: :any, x86_64_linux:      "8c4237e1866c28339afb9f30a5978813d43b4b3b8ca2fbf897fc0cbd2b297af9"
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
