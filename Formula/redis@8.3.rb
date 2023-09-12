# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT83 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.0.tgz"
  sha256 "901d5a0e52236c1c885a6c970870e089ea46de41d9027a92b6a9bad26ae1cdfd"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "d294c3f234e67475a51702b5f7737ae518cc46ab708e9efff8160b19d4ca0f88"
    sha256 cellar: :any,                 arm64_big_sur:  "f531d02eacb6cadc029ca304ec895eacde6ae7ba08abbc0bc322c4b88493ce3d"
    sha256 cellar: :any,                 ventura:        "c3504c559698b092096d995bb06d77688507d257ff1790e2e38c51a5831e9efa"
    sha256 cellar: :any,                 monterey:       "aec9a2a37a253c7fea6917144949a860b6c8956c6aed380556d41c3d37f07e82"
    sha256 cellar: :any,                 big_sur:        "422d8d50a31b99fe5b461f4adebbf3da1a7acac973da19d30d6c9751dec9a0dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1e9f261afbed242a4c0a80b5b5bd3755d5019d16cb2de0d72c05efc3b844dd46"
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
