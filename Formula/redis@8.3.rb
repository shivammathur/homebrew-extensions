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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "6e59c32a290975e3bdda00d266877d52b87833d7828e6a863779b5494c96d93b"
    sha256 cellar: :any,                 arm64_big_sur:  "66adc0b12b9b376715e501ef7d641ba81b6d49de506b834fe6a63f4f4987fb55"
    sha256 cellar: :any,                 monterey:       "8b7ed2cfe70ddb884c32a8d862f3835c386b70ccee67ef37f8eec527bb07652b"
    sha256 cellar: :any,                 big_sur:        "1ab083f5624e443e713e6b2e9478549477672049e2ad6005dabb1bf0ad241d84"
    sha256 cellar: :any,                 catalina:       "b1946b16e72a9a9b50f4933c389aabfb150a31b3f0bbaccc79d2be3d786f1d33"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "248ff9a9a5b15894fa81820013deac36a94e5e40fd267f94f01d8fb7292e61cc"
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
