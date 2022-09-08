# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT82 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-5.3.7.tgz"
  sha256 "b958166ccda4f40bd17c6998f9e2239021ae644467cd8ad5c15def420aad65b0"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "46dc9cf9028ae33bdde52b52963ea710e39b33f9b1dd2c0b04bcf3e5d19d6d41"
    sha256 cellar: :any,                 arm64_big_sur:  "75f50dca7940a9205a516d460543b88973b7e6ea4295f78e1336e827d2aaee23"
    sha256 cellar: :any,                 monterey:       "e7870c445b0605e3f71cc582b7d18a3bc9ce59359e001a396e8614d48d2ab7d2"
    sha256 cellar: :any,                 big_sur:        "a44ed9865950ab930965263dbeb0d9b72cca0f465b26f533d287cfdebea8915d"
    sha256 cellar: :any,                 catalina:       "f0d0b5e040146749f53e7e2f02ff5b7c50f23ac5f4cf76ab71cc392cbdf6ed34"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "297384df9afc51a4982f2bc8c996379f6aee91efd2139eacf815b043210bbcf7"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.2"
  depends_on "shivammathur/extensions/msgpack@8.2"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.2"].opt_include}/**/*.h"]
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
