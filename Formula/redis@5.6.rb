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
    root_url "https://dl.bintray.com/shivammathur/extensions"
  end

  depends_on "liblzf"
  depends_on "shivammathur/extensions/igbinary@5.6"

  def install
    args = %W[
      --enable-redis
      --enable-redis-igbinary
      --enable-redis-lzf
      --with-liblzf=#{Formula["liblzf"].opt_prefix}
    ]
    Dir.chdir "redis-#{version}"
    inreplace "config.m4", "ext/igbinary", "ext/igbinary@5.6"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
