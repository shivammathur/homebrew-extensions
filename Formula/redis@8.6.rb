# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT86 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.3.0.tgz"
  sha256 "0d5141f634bd1db6c1ddcda053d25ecf2c4fc1c395430d534fd3f8d51dd7f0b5"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/redis/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "59b6e0cd2cbd06cb99d31f37102f6484122f511cea2956f97d33b28c9c43d8b8"
    sha256 cellar: :any,                 arm64_sequoia: "d709747cafc1154730610ccd157f3651c77a358f9d96990d9e239d44db0ede26"
    sha256 cellar: :any,                 arm64_sonoma:  "9b8829ea6527a3581ab71c1490e070ac7c5fea5af8e6fbc1fdc0ca341b326a9c"
    sha256 cellar: :any,                 sonoma:        "2e08e7d78af38ddc4b3146e0d6726268a73c8c0a73a02a535fb8ae414c8247c6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4ea13114144b04a9ce3cfec4e90e5c7c397eee6c83c85ba2d180ccd3c85a784d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7d0cb634a2c7793e4ae5108b638a9bd719f353095ce0f742bd9a87ef8083cf95"
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
