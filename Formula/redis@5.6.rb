# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT56 < AbstractPhp56Extension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-4.3.0.tgz"
  sha256 "c0f04cec349960a842b60920fb8a433656e2e494eaed6e663397d67102a51ba2"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "2ee1119eb42fc841c3fc5b8aac4a1b8fa5b33a872dc1ab478affdc191813b117"
    sha256 big_sur:       "313ba4b0da7e2e3296f2cc9ef43718099d3234d0295f1aa47ef9aa12a00477bd"
    sha256 catalina:      "ef273037209ec1b12b0a066a43148b9e4202a69e3801e224a5cda298fe052aea"
  end

  depends_on "liblzf"
  depends_on "shivammathur/extensions/igbinary@5.6"

  def patch_redis
    mkdir_p "include/php/ext/igbinary"
    headers = Dir["#{Formula["igbinary@5.6"].opt_include}/**/*.h"]
    (buildpath/"redis-#{version}/include/php/ext/igbinary").install_symlink headers unless headers.empty?
  end

  def install
    args = %W[
      --enable-redis
      --enable-redis-igbinary
      --enable-redis-lzf
      --with-liblzf=#{Formula["liblzf"].opt_prefix}
    ]
    Dir.chdir "redis-#{version}"
    patch_redis
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
