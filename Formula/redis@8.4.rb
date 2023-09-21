# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT84 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.0.tgz"
  sha256 "901d5a0e52236c1c885a6c970870e089ea46de41d9027a92b6a9bad26ae1cdfd"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "9ed9ed25625ddb3e38f96aadb012ffe2215278d506c24858894ed611b334ccba"
    sha256 cellar: :any,                 arm64_monterey: "f6b01b3b345d617e11d7a65a4803060cadfa84e5c54dee2d66634a8ac800410b"
    sha256 cellar: :any,                 arm64_big_sur:  "e2f8ca55a3b54b666eced886dad724ebe2ccb2705b27020f65e8558290ebefe3"
    sha256 cellar: :any,                 ventura:        "60296b4e445856b005cb2ba90924d53c30d89c215d37c6c416d1dcdcf0766832"
    sha256 cellar: :any,                 monterey:       "78942c31816d2dc24a7b9c9e4302f5eeb3790712f3ce77c7225b8a0cd0ed37b1"
    sha256 cellar: :any,                 big_sur:        "513c2b8379bc88837fc207b1b40c374a85b846237c4a40f5dbfe0441b03b8370"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4961dbe3268adfbb7e1c28967fd6a0f2a99c6976d1ec86d7c24fc3b0f6d0f1c2"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.4"
  depends_on "shivammathur/extensions/msgpack@8.4"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.4"].opt_include}/**/*.h"]
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
