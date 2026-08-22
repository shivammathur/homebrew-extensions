# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Lua Extension
class LuaAT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "2a2afab20a643109212cf13f14a162984dcf27b659b71ec9dafbe39a90efd952"
    sha256 cellar: :any, arm64_sequoia: "56f894bca8d45a77c6023d2a8d1f3b61e8e090a4913665289c4c8c18eedb7e52"
    sha256 cellar: :any, arm64_sonoma:  "e5bd952765c9e17eec50e1aa1431ae2d1fbb875e72f244f1a8d7270feb6cc9d2"
    sha256 cellar: :any, sonoma:        "d35ef8b514915197059c9e942b0adfc890f8bdd9dc30917a91d1acc32e6663ac"
    sha256 cellar: :any, arm64_linux:   "b9248042239d7629742ef2b2e2f49e44775791355df2cb75bcb12b3757974385"
    sha256 cellar: :any, x86_64_linux:  "b13eefb50366db4d3875f71e587f3238380b82bbb020fe4e77b42dc1ec5b8a9c"
  end

  depends_on "lua"

  source_directory = "lua-#{stable.version}"

  patch do
    url "https://github.com/laruence/php-lua/commit/f7012e45faf6431e3c45bbfef683a6ec7180d86b.patch?full_index=1"
    sha256 "379d245a7580775734330c3c8806354a4f112f4151902ae887460af6d7596fb3"
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
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
