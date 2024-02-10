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
    sha256 cellar: :any,                 arm64_sonoma:   "5e43a824b9276d003a696c6d37092b9f5d32b2fcec61fa9d51d1902079ae2971"
    sha256 cellar: :any,                 arm64_ventura:  "d1c23364eb16a90f647875dfe2400862ae9a6d4ae081be2bd2299950361227dd"
    sha256 cellar: :any,                 arm64_monterey: "cbdcb4423a86305e04ea3d1832426a5387f5b487e5ac3ba84a03ab414b7b5111"
    sha256 cellar: :any,                 ventura:        "ceeee69a553458af5297fcc3dc72fef2239e2dfa768445634c57194a28816872"
    sha256 cellar: :any,                 monterey:       "ca5655acea7560cfc4980473da2d6fcc1b2053e511a8bcbb55b53b1a822395b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8b7b9cc2446816085e53ada61022987e6c43f1d238b2a7db55f895347527d42d"
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
      s.gsub!(/#include "php_mt_rand.h"/, "")
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
