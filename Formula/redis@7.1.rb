# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT71 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-5.3.4.tgz"
  sha256 "4b39056f3356f135255e059efd76398d1c7607c86bd52513e6341bb07a3fb4cc"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_big_sur: "a21c03b001ad3fa2c49e8586def2ea42a6b018c793842644b66a004bdededc9e"
    sha256                               big_sur:       "d10e64f96b53a58834d8d44e94d60dece392c5c8868b1c445ac7cdea67e9987e"
    sha256                               catalina:      "d176f6035d7948f8c60fc008ebb3adfdfb7ca3f1cca4c1a99ddd007194aa95f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9539fc7a5a23b58af4fe39f652ddb315af82e58ba015b15f35934f7e2b9d22d5"
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
