# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "8ccb4bc37bf67aed48bdf9d2ac0cdd52ad163aba4619985fd2e87bd284aeeba1"
    sha256 cellar: :any,                 arm64_big_sur:  "4dc725446606537aa783f04a178aa6a7d1ac1b053c96ef9af118f3a977468387"
    sha256 cellar: :any,                 ventura:        "c9c0cf91c5a2409f1bb63be903a6fd67388d69785e9c21e21ed519a44d050261"
    sha256 cellar: :any,                 monterey:       "192af83e5666a2ebd50c49786513889474f7a92f3b235ce31f7266efe9858b1d"
    sha256 cellar: :any,                 big_sur:        "b1478afbe9f30d9069bd92b0ce5de0abba32040712b4fbc190bfbe2721af9704"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b40423ff4d71cd7baccdc872894dbc88934ef15b7905e192d1fcf387eab4dc4d"
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
