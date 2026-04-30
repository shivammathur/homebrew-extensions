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
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "77f381bf6f84f83eebbe665c4dc91ec0f7daa017a32c6f166dea4e187d0b607c"
    sha256 cellar: :any,                 arm64_sequoia: "bf0a6cbf1c2cf75eba9cf8333a5694c24530c7156c56a5078c648f6c463d3f96"
    sha256 cellar: :any,                 arm64_sonoma:  "d49ab5e8c89672de2b1b5f350819b04a11a3ec71e0515b8e89031300b605b61d"
    sha256 cellar: :any,                 sonoma:        "cc5aa214ae795ae42bec40f5b30a6c7fd8d93500a188e92288d7dc9877f345d2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7b23ce61ec93568668ce222a3b850984157a4336c67503fc9c9b4ad2eae15c95"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c5630d47d5fb53f659908bc837c875cfda0d3c6a2df147a999b02d609da963b6"
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
