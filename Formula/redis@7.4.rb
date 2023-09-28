# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT74 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.1.tgz"
  sha256 "d39136e0ef9495f8e775ef7349a97658fb41c526d12d8e517f56274f149e1e4e"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "5b28bde9c0c84248d32abb26aaf5dd555ca68f5f80c9daa4f926066c700188e5"
    sha256 cellar: :any,                 arm64_monterey: "52a711de25b871db2fda28b77d8133c120e0adf2c77c0e44411aef4ee7ac11e7"
    sha256 cellar: :any,                 arm64_big_sur:  "b42e85a05f4cfd6d34293dedc22ba67fe03be30b26ee6e518a71324a3fcfa289"
    sha256 cellar: :any,                 ventura:        "1ffdcf993e59038e60bd4a3eb291603d90210cd340c2bc9a2901f0dc958cf391"
    sha256 cellar: :any,                 monterey:       "427742760b8163ae192c0d3e8138357bd3cceb7e2e8e8c284db0803583be9133"
    sha256 cellar: :any,                 big_sur:        "eb70184bf97d240ab237c2c21f7a393729fdd858201cdf2fe14bd81b8fa6d802"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "068164cf18db2eb58fd00ede354b075cff73b30977a6fd763d4e08699d8e91a2"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@7.4"
  depends_on "shivammathur/extensions/msgpack@7.4"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.4"].opt_include}/**/*.h"]
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
