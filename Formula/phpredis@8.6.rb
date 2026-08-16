# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class PhpredisAT86 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.3.0.tgz"
  sha256 "0d5141f634bd1db6c1ddcda053d25ecf2c4fc1c395430d534fd3f8d51dd7f0b5"
  revision 1
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/redis/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_tahoe:   "4cd4886ae7a2b7ae94854c6b1261c83f2205b1c41e6de1e47ec0bce9508572d5"
    sha256 cellar: :any, arm64_sequoia: "453849c6a42b22e9b1e59674e56ee4799c0f41d9d3e208a2733afc4d94991c76"
    sha256 cellar: :any, arm64_sonoma:  "5b2c90249ba2c1c7bbd1202a9e4defac5556392a9880ad9a3a8980bcec869bbe"
    sha256 cellar: :any, sonoma:        "1567b9c2990ee399da9360d1bfc03f14445e1dd70034fd3049f89578a1b8013c"
    sha256 cellar: :any, arm64_linux:   "460f7045e32631c25b915fccf2fbbb4cbe95ee457bf7a1e066498bb752913ac0"
    sha256 cellar: :any, x86_64_linux:  "7200ee76aaa2cec79b47324b87d74f983ed90119d76ec16b033953d137b67a54"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.6"
  depends_on "shivammathur/extensions/msgpack@8.6"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Utils::Path.formula_opt_include("#{e}@8.6")}/**/*.h"]
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
