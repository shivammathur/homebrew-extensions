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
    rebuild 2
    sha256 cellar: :any,                 arm64_tahoe:   "7cb26b8b6d828066234d7924ec324161d2022ff3495da00fc770a1a0583a33cd"
    sha256 cellar: :any,                 arm64_sequoia: "57bf12f7ecfcd6e7a128ced3a03a960d039bc6124d6b2fc406aa4135b5f71357"
    sha256 cellar: :any,                 arm64_sonoma:  "f0d6e6decc446507a1070baf7b44aecac300f2e4ff52a3defeb2e998710d6dac"
    sha256 cellar: :any,                 sonoma:        "318732bf5230c3b67cf98dc1c75cf27ef1f396c2aef8ec95a8c7fc690b354013"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a17fdd37f91c0c5bfa15f18660c67e58f2ed6a9e00f6e51f679b71131cf63a98"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b66d39a54c0f1308263593ce0d3125d5d68e7f68c9d9fd91f8371deb12f51ad2"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.6"
  depends_on "shivammathur/extensions/msgpack@8.6"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.6"].opt_include}/**/*.h"]
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
      --with-liblz4=#{Formula["lz4"].opt_prefix}
      --with-libzstd=#{Formula["zstd"].opt_prefix}
    ]

    on_macos do
      args << "--with-liblzf=#{Formula["liblzf"].opt_prefix}"
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
