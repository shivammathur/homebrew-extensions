# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT83 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-5.3.7.tgz"
  sha256 "b958166ccda4f40bd17c6998f9e2239021ae644467cd8ad5c15def420aad65b0"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "5f9e9b2b5bcbf521bc248c03a435cca400ac994069869d68e6f941073132268d"
    sha256 cellar: :any,                 arm64_big_sur:  "6b518988d0aae1613afdf6f3cb60d50d7f878d7d9b2e020fdc5ab3ca7e440d58"
    sha256 cellar: :any,                 monterey:       "a80cc7f69d1e104db6fdefacbe8c5dbf70e3b7845d5ce8defde4cd87f0ba4a5f"
    sha256 cellar: :any,                 big_sur:        "4aac8f69c69e6befa97a4f9a72a465aae82d4da22abec0295edc49bcd9dacb3d"
    sha256 cellar: :any,                 catalina:       "c21f2775b7268d18319677f950b98833783e6573dca9bc7880a76dba55c1b1be"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "07d94bb571d0f90460866df2963f0d2dbc0f364117eb8cfa5c8b13690d73b172"
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
