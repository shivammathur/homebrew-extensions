# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT71 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-5.3.7.tgz"
  sha256 "b958166ccda4f40bd17c6998f9e2239021ae644467cd8ad5c15def420aad65b0"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_ventura:  "ea88dfa539aa2b968e4a984484f1b0cbec10f8256954f095cfb7b7598965ec0d"
    sha256 cellar: :any,                 arm64_monterey: "5918bbdc2c9508275cd621689518732301ee7dd2950336737ad9308c6e5ab0ea"
    sha256 cellar: :any,                 arm64_big_sur:  "9cd7e6335b47ece519e0632f3edd94473d15d8237d6c9abf87fb8db08f03692f"
    sha256 cellar: :any,                 ventura:        "cb5d88f76a7cf8f3ec0a7de3aa19a94a13caf4cb7043a6bf2b46e54eedeafe45"
    sha256 cellar: :any,                 monterey:       "b383593ae7ea7ad6672e65057dffa886274df8efe426a1977fba168572508ab4"
    sha256 cellar: :any,                 big_sur:        "8b321def508a973679eb04e8e3372209587a9e77ad47bf47eedc0ce93a26de7a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e89628fe817f2864652a5741695c10ae078ccb89b5ecc40e9e2677f3d80814b2"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@7.1"
  depends_on "shivammathur/extensions/msgpack@7.1"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.1"].opt_include}/**/*.h"]
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
