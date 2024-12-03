# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT72 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.1.0.tgz"
  sha256 "f10405f639fe415e9ed4ec99538e72c90694d8dbd62868edcfcd6a453466b48c"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "2a03dd292c38d03396c712900d2b3e7d6db1414529831eb708edc6072e28f7a3"
    sha256 cellar: :any,                 arm64_sonoma:   "88aff07b870ab94d73c0fc515f9d1a826df52016503ca47527877d2e1d0b1c2e"
    sha256 cellar: :any,                 arm64_ventura:  "3bd4322660342fe181e20b9f2f60501fe4d80dbb2aa3a15720c85e46ca5aec9f"
    sha256 cellar: :any,                 arm64_monterey: "74314e29ac85329e6ba888e188c7b3cba1e512af0d964c6823573edbbdca0aad"
    sha256 cellar: :any,                 ventura:        "c3d1a79b046a4818e867bf2932497af6ddc1e25ac6e39478449396f8955ae114"
    sha256 cellar: :any,                 monterey:       "0c6127265cadc74b5b9414eca49d6eee4e32b0523f700fd43d94073b31c25f25"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "39c001bd67b93b0d4bf0a7862f3963293173b2cf69c77cb0c01b6bc5db1a00ce"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@7.2"
  depends_on "shivammathur/extensions/msgpack@7.2"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.2"].opt_include}/**/*.h"]
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
