# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Lua Extension
class LuaAT83 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "b5bc14d972dc46a8223db9bce4b1a0ae7f211ed2d4e0dc0add63bdd1a4bd49a7"
    sha256 cellar: :any, arm64_sequoia: "ce8f3391e65a6ef25ef67e8b5cb20e356d91c8c97b62d78cdc7003c3d2898936"
    sha256 cellar: :any, arm64_sonoma:  "98b2aed05d2e41d47518cf9f06f16a8e5e7848d5f4a64880e9520a6daad0a70f"
    sha256 cellar: :any, sonoma:        "75e5183a1cc6f443bbc008e527f8f598ff14536c40dec7020f11f6b9883795bb"
    sha256 cellar: :any, arm64_linux:   "d54c103ad08d51993b13837ce7b3d64d4410db3e45d9cd02b40cd7e4619bdf76"
    sha256 cellar: :any, x86_64_linux:  "9b05d3faa722beb16308c4ad6f90d2b45c0bbfa73d9d956c5211c73d70116764"
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
