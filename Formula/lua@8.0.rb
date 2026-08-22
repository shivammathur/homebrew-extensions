# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Lua Extension
class LuaAT80 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "810c16d37c1dd8fb9be355e50376c19876fff923569fda575eb1821bdc2cc697"
    sha256 cellar: :any, arm64_sequoia: "d4b5e262d4106beafca92d2ee02aa3c8d396c93d227da61bb97f1fa98b006b75"
    sha256 cellar: :any, arm64_sonoma:  "c216ab31ab8ca54630ff2d4455d9eb4ec52d20a2cfaf1ec533a815bd311ce02e"
    sha256 cellar: :any, sonoma:        "52ff382552e144482e105f937e52b478c0189a70cf432b7489379afa0215feb0"
    sha256 cellar: :any, arm64_linux:   "61ddb4530680f31c8ab1014afcaad9d4d1595a3fedf72a3dd88d4c3e73eb250c"
    sha256 cellar: :any, x86_64_linux:  "ab457e979243d87f73f63d42e5d376409c4695530468ccb6cf6056f5fe078b8f"
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
