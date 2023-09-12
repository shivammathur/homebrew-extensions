# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT82 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.0.tgz"
  sha256 "901d5a0e52236c1c885a6c970870e089ea46de41d9027a92b6a9bad26ae1cdfd"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "db8c0cd28e67fec0d9a6d27fc39bebb7bac4fe88f3ea247a5a34c2c7e0756155"
    sha256 cellar: :any,                 arm64_big_sur:  "6be1c1a1fdf52d94ee8c522bad4d7d6dc7f89f77f78987b6dd1ee3d2ad72c785"
    sha256 cellar: :any,                 ventura:        "cd35daa70c2a7d6bbe058dfc05d2d693824b939f218d169583b612531bfdc862"
    sha256 cellar: :any,                 monterey:       "cf70bc9c3f176211d594f61ccdc9b215ffab09a3ed8ec8d4875157edd2d63de3"
    sha256 cellar: :any,                 big_sur:        "6cdc738be806fc30b68ce4fd4704cac2bc0b9064d2d79418c0d4657ef276acb7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "458b5c3d47f08121cd12f46c8d4dab8c2d155da6cbe6dd651c40bd85b59e99e7"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.2"
  depends_on "shivammathur/extensions/msgpack@8.2"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.2"].opt_include}/**/*.h"]
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
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
