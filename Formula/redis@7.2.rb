# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT72 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-5.3.7.tgz"
  sha256 "b958166ccda4f40bd17c6998f9e2239021ae644467cd8ad5c15def420aad65b0"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "93c8d23000b0acbc88492ad35286e7381d161b62ba434bba218292854306ab25"
    sha256 cellar: :any,                 arm64_big_sur:  "17735d5eccca06ae6ce7433585e4d79cdd3e09f0047f627e98191adada012730"
    sha256 cellar: :any,                 monterey:       "63d306e791ddf10c81366996c0ded70b7110fb1dfc68c59b04b1fefce1c8e28d"
    sha256 cellar: :any,                 big_sur:        "d14e0e360b1662deb7d7a66b8b2bea897cfcccef7d16d9af27ae8cb005ccce6b"
    sha256 cellar: :any,                 catalina:       "3cf1305bb580e4ccd609ca92d1835c3d77bfb499d8d9cff6901bf64bd1f9ce86"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ab3ab877c2a64a09a21a6c31c59bb304ecb7d2f78ad46e213879c630fe25355c"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@7.2"
  depends_on "shivammathur/extensions/msgpack@7.2"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.2"].opt_include}/**/*.h"]
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
      --with-liblz4=#{Formula["lz4"].opt_prefix}
      --with-libzstd=#{Formula["zstd"].opt_prefix}
    ]

    on_macos do
      args << "--with-liblzf=#{Formula["liblzf"].opt_prefix}"
    end

    Dir.chdir "redis-#{version}"
    patch_redis
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
