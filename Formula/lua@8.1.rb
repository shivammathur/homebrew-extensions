# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Lua Extension
class LuaAT81 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "0c85667775daf647c7f24d2d9e0bafd2fcd9d6a91c5cf5d57d379ffb3737d9f6"
    sha256 cellar: :any, arm64_sequoia: "8ae99c34694147966ebb7668974fa23c3dbcc3b9651b4f46dcba75b6460a9698"
    sha256 cellar: :any, arm64_sonoma:  "2a263072eb175dfd0e219dffe20a0694103905af443ac634a8340eb195062bb2"
    sha256 cellar: :any, sonoma:        "cba96ee87024f53bc355f782ae2e1e0e65034400b14b8d9512c9f69fb587a8c4"
    sha256 cellar: :any, arm64_linux:   "4383cc9d5ae2672fb0298482cd99788563dfa12c5b9bee557faca037d05c5d6d"
    sha256 cellar: :any, x86_64_linux:  "8d191bc093fc43ec0bf8d496580be51b38f1b3aa4fb5afd7be0d3b659299d27d"
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
