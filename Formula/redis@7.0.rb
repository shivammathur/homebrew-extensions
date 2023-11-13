# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT70 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-5.3.7.tgz"
  sha256 "b958166ccda4f40bd17c6998f9e2239021ae644467cd8ad5c15def420aad65b0"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_ventura:  "a03b80338aa510771e86e928d65b0b403afe9e8107da02059a4b0d4fdb690689"
    sha256 cellar: :any,                 arm64_monterey: "f31d4411c8087cf667520d9a038b95347480b67278a02dc6d249e0cd84c6e971"
    sha256 cellar: :any,                 arm64_big_sur:  "8e29ccb3631e64c946ec23b47105fd01fdaa3b8231c927bc9d1996a7b61651c8"
    sha256 cellar: :any,                 ventura:        "b88ef4abeb335491fa00beaf5f761f42917fc91bdb3985cd82bbd90e490494e9"
    sha256 cellar: :any,                 monterey:       "d73dde370aa8655950614a4961a070e8dcddc6ae9683e9c94ca70d569a6bb48c"
    sha256 cellar: :any,                 big_sur:        "be5eec322420551bdd07567de667ecf961b07c28841eba4e534534fa3c9b8145"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "358ed0f5858280bfced25cddbcf17c213e71114e05520e6b0059a3e232a66479"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@7.0"
  depends_on "shivammathur/extensions/msgpack@7.0"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.0"].opt_include}/**/*.h"]
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
