# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class PhpredisAT87 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.3.0.tgz"
  sha256 "0d5141f634bd1db6c1ddcda053d25ecf2c4fc1c395430d534fd3f8d51dd7f0b5"
  revision 2
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/redis/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "70b73a8b585f88c1d7b3d202e646857c23900f3ecd351ae44d9d20cddac9ad3c"
    sha256 cellar: :any, arm64_tahoe:       "dd5c6bb28c9ab14ea1b012b01e23fd6860632cc2b7328c9e2c2e878e82bc35ea"
    sha256 cellar: :any, arm64_sequoia:     "c085ef81e1fd507386ab6e8dbd45b97cc9d41ae1dfb886b6dc403aa43a89df82"
    sha256 cellar: :any, arm64_linux:       "609514d9e606692dd14d2d0e5127c657e1d9121f456f083733dbced0a7453e4e"
    sha256 cellar: :any, x86_64_linux:      "870fceac713d9aeb1bfaaf0a86f87b703f7865153cdce14276a8cb646a156eba"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.7"
  depends_on "shivammathur/extensions/msgpack@8.7"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Utils::Path.formula_opt_include("#{e}@8.7")}/**/*.h"]
      (buildpath/"redis-#{version}/include/php/ext/#{e}").install_symlink headers unless headers.empty?
    end
    %w[
      redis_array_impl.c
      redis_array.c
      redis_commands.c
      redis_cluster.c
      cluster_library.c
      library.c
      redis.c
      redis_session.c
    ].each do |f|
      inreplace f, "zval_dtor", "zval_ptr_dtor_nogc"
    end
    inreplace "library.c", "#include <sys/types.h>", "#include <errno.h>\n#include <sys/types.h>"
    inreplace "library.c", "ext/standard/php_rand.h", "ext/random/php_random.h"
    inreplace "backoff.c" do |s|
      s.gsub! "ext/standard/php_rand.h", "ext/random/php_random.h"
      if File.read("backoff.c").include?("#include <ext/standard/php_mt_rand.h>")
        s.gsub! "#include <ext/standard/php_mt_rand.h>\n", ""
      end
    end
    inreplace "redis.c", "standard/php_random.h", "ext/random/php_random.h"
    inreplace %w[library.c redis.c], "php_hash_bin2hex", "zend_bin2hex"
    if File.read("common.h").include?("ext/standard/php_smart_string.h")
      inreplace("common.h") { |s| s.gsub! "ext/standard/php_smart_string.h", "zend_smart_string.h" }
    end
    %w[
      library.c
      redis_commands.c
      cluster_library.c
    ].each do |f|
      inreplace f, "zval_is_true", "zend_is_true"
    end
    %w[
      redis.c
      redis_cluster.c
    ].each do |f|
      inreplace f, "ZEND_WRONG_PARAM_COUNT()", "zend_wrong_param_count(); RETURN_THROWS();"
    end
    inreplace "redis_cluster.c", "WRONG_PARAM_COUNT;", "zend_wrong_param_count(); RETURN_THROWS();"
    %w[redis_session.c library.c redis_array_impl.c cluster_library.h redis_cluster.c].each do |f|
      inreplace f, "INI_INT(", "zend_ini_long_literal(" if File.read(f).include?("INI_INT(")
    end
    %w[redis_session.c library.c redis_array_impl.c redis_cluster.c].each do |f|
      inreplace f, "INI_STR(", "zend_ini_string_literal(" if File.read(f).include?("INI_STR(")
    end
    inreplace "redis_session.c" do |s|
      s.gsub! "strlen(save_path)", "ZSTR_LEN(save_path)"
      s.gsub! "save_path[", "ZSTR_VAL(save_path)["
      s.gsub! "save_path+i", "ZSTR_VAL(save_path)+i"
      s.gsub! "estrdup(save_path)", "estrdup(ZSTR_VAL(save_path))"
    end
    inreplace "library.c", "EMPTY_SWITCH_DEFAULT_CASE()", "default: ZEND_UNREACHABLE();"
    inreplace %w[
      common.h
      redis.c
      redis_array.c
      redis_cluster.c
      sentinel_library.c
    ], "XtOffsetOf", "offsetof"
  end

  def install
    args = %W[
      --enable-redis
      --enable-redis-igbinary
      --enable-redis-lz4
      --enable-redis-lzf
      --enable-redis-msgpack
      --enable-redis-zstd
      --with-liblz4=#{Utils::Path.formula_opt_prefix("lz4")}
      --with-libzstd=#{Utils::Path.formula_opt_prefix("zstd")}
    ]

    on_macos do
      args << "--with-liblzf=#{Utils::Path.formula_opt_prefix("liblzf")}"
    end

    Dir.chdir "redis-#{version}"
    patch_redis
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
