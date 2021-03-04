# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT81 < AbstractPhp81Extension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-5.3.3.tgz"
  sha256 "37789161e164cd52239a30c9a238da61fec5c8395cdac385b6ed8f0c50fd92f0"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 2
    sha256 arm64_big_sur: "64c32d9963a53d6d121995bb0168c7378771f3cffe9728b915c42c61795353ae"
    sha256 big_sur:       "a65337c1a0ff2cbb176f447e4eaf2e27c50edac5c67a39d6e7d60133ca2ded0f"
    sha256 catalina:      "78b2908366081ab82a8f94fcfad95b7c6cc3471278b5c9bf5d5503edce078844"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.1"
  depends_on "shivammathur/extensions/msgpack@8.1"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.1"].opt_include}/**/*.h"]
      (buildpath/"redis-#{version}/include/php/ext/#{e}").install_symlink headers unless headers.empty?
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
      --with-liblzf=#{Formula["liblzf"].opt_prefix}
      --with-liblz4=#{Formula["lz4"].opt_prefix}
      --with-libzstd=#{Formula["zstd"].opt_prefix}
    ]
    Dir.chdir "redis-#{version}"
    patch_redis
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
