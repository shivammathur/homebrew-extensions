# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT83 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.2.tgz"
  sha256 "01aeccb0e14f897fe56f0509be6e6991ff0ad459f9d34e95e4556d02699b9a03"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "004250286d35de8611a3290245aaf838ed60c441e26f57272dfa021e4079c859"
    sha256 cellar: :any,                 arm64_ventura:  "ae4395544ed61ac954439d88072041e1289549d1a249fbc4e71282cd31cc2cd8"
    sha256 cellar: :any,                 arm64_monterey: "8a41a1b18cd9d5260959edeedf18241396ba50f71a741a8a5ddf12b9aa1f30a0"
    sha256 cellar: :any,                 ventura:        "e0bcf3fe4f31859c35ef01e7273a144605752ba2f2c8709c643ba719f291ccfc"
    sha256 cellar: :any,                 monterey:       "ec51732254bef30806984696d4d5ef306787c4838346b7a01dfcb9ed810e8c25"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "877dcdea9b8c5274879806d9bf844a8a09b0f5ce1e41a641fa599252b86de888"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.3"
  depends_on "shivammathur/extensions/msgpack@8.3"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.3"].opt_include}/**/*.h"]
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
