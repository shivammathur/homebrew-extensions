# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT80 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.0.tgz"
  sha256 "901d5a0e52236c1c885a6c970870e089ea46de41d9027a92b6a9bad26ae1cdfd"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "ad7c05e260bf3a12ca3262e8734c00f8a204e0db4500990b31f21e3249bfb144"
    sha256 cellar: :any,                 arm64_big_sur:  "12cfd43ab7d9bd978a04ffe6a679f8abf4dd43637a8a7c4e48e8a3e648f6d557"
    sha256 cellar: :any,                 ventura:        "8c631b48ca5d714a0cd4feac71f304c8e01ec5fa082ed6e5b4ffb2fb8aecaa75"
    sha256 cellar: :any,                 monterey:       "aaeb419e8fe44925aea6cff54181158a88e5f83db31ae5a500c54f9ce21636bf"
    sha256 cellar: :any,                 big_sur:        "d4d4f82bcfb4b338a5ee0d21b2c0f49649ba9c1992a401e4d34fca260e6175f9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dc02eb8f49f421732f45f553fbf76495a3df4bcbdb84d0d5d8abf0546e6eee82"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.0"
  depends_on "shivammathur/extensions/msgpack@8.0"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.0"].opt_include}/**/*.h"]
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
