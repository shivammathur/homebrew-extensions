# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT81 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.0.tgz"
  sha256 "901d5a0e52236c1c885a6c970870e089ea46de41d9027a92b6a9bad26ae1cdfd"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "e17db28dc561f49be70ee57fd8b2db2870c07780d6963195fd14cce76d30413c"
    sha256 cellar: :any,                 arm64_big_sur:  "0277ff530f79b827bc87b57c31a5efef42d11b22f7ff8dbc291ab12e8cb8207a"
    sha256 cellar: :any,                 ventura:        "74ac8b82b57cb66e83de3c22f9dd17292907a5e8bf998310bd470edbbd4c5d36"
    sha256 cellar: :any,                 monterey:       "550b2da6edc5300f248626ef7ae4a2f711c392db771a4e7e8d0210e2093f1fb2"
    sha256 cellar: :any,                 big_sur:        "15d8ec7b28afb6ba5ad2885c1e7a8899c39919d95a61a1b94db7545ea9a9afc5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d7ad4629818276685e78f1e7bb05fa97bd2bbbc0cfdd107965205cf858ae39ee"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.1"
  depends_on "shivammathur/extensions/msgpack@8.1"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.1"].opt_include}/**/*.h"]
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
