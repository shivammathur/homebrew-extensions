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
    rebuild 4
    sha256 cellar: :any,                 arm64_tahoe:   "9dca56104b20b9c54d35ffdd83811bb082971ffdf265b441a2d74a320aee5c16"
    sha256 cellar: :any,                 arm64_sequoia: "ba5026561defa3ab58273d38f4c56ac840dc81cc62ae396c9c711c3684714f96"
    sha256 cellar: :any,                 arm64_sonoma:  "7c407f3e2f185a592f611f32de53a85067118cc51cd0b194de8f79858fb391b2"
    sha256 cellar: :any,                 sonoma:        "07f78bdee48e8634001652d9f0a74f227dac63e735242c7f18a7e0ac1302f1e7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "58fc4c1d16b3583a1ff6caa9cf291e9d240cc11f3b27808d30270adc535c677c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c53a9d422c1f76ea0fad5939d09ed4781d6d1992f3c9576bbcb58b4004bfabf7"
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
    %w[redis_session.c library.c cluster_library.h].each do |f|
      inreplace f, "INI_INT(", "zend_ini_long_literal("
    end
    %w[redis_session.c library.c redis_array_impl.c redis_cluster.c].each do |f|
      inreplace f, "INI_STR(", "zend_ini_string_literal("
    end
    inreplace "redis_session.c" do |s|
      s.gsub! "strlen(save_path)", "ZSTR_LEN(save_path)"
      s.gsub! "save_path[", "ZSTR_VAL(save_path)["
      s.gsub! "save_path+i", "ZSTR_VAL(save_path)+i"
      s.gsub! "estrdup(save_path)", "estrdup(ZSTR_VAL(save_path))"
    end
    inreplace "library.c", "EMPTY_SWITCH_DEFAULT_CASE()", "default: ZEND_UNREACHABLE();"
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
