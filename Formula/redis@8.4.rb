# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT84 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.2.tgz"
  sha256 "01aeccb0e14f897fe56f0509be6e6991ff0ad459f9d34e95e4556d02699b9a03"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "13362da40c6a35485d2500e9d168dc171716c13d787515473d269c5c70be1a24"
    sha256 cellar: :any,                 arm64_ventura:  "784d8a7f227b763bd30bff6a1f9c45df68d7d8d5ee233db5d4bb69f016786c09"
    sha256 cellar: :any,                 arm64_monterey: "ecdc37fe63381476668838725047dd196fa94dfad40c8ff20273a4442aab89d2"
    sha256 cellar: :any,                 ventura:        "f41b95226e5ae834c7319d51ae0834c88028e7ec279dd0288cd070462e93fda0"
    sha256 cellar: :any,                 monterey:       "832a1c9eb83336cdc288520235fb2371cfb0fa740298076c13f259ffa3fc6dd6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d7f3deb09426a594bf57551e0cef57c2afc7e894bd7911288de2d1edacf9f8ea"
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
    inreplace "library.c", "ext/standard/php_rand.h", "ext/random/php_random.h"
    inreplace "backoff.c" do |s|
      s.gsub!("ext/standard/php_rand.h", "ext/random/php_random.h")
      s.gsub!("#include <ext/standard/php_mt_rand.h>", "")
    end
    inreplace "redis.c", "standard/php_random.h", "ext/random/php_random.h"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
