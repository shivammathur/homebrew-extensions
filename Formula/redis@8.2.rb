# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT82 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.2.tgz"
  sha256 "01aeccb0e14f897fe56f0509be6e6991ff0ad459f9d34e95e4556d02699b9a03"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "9821485cb64832977af86c6261109432be2a0bb133f5c728c108d537b7d59d11"
    sha256 cellar: :any,                 arm64_ventura:  "49a78ac2c59a27e2e552aaae3092fc31e91206ac64885cb9e6610949da1124da"
    sha256 cellar: :any,                 arm64_monterey: "cbf140bce8d3f007df58964c1a52303b8aef097db0aeb22a7310442fbb4d1858"
    sha256 cellar: :any,                 ventura:        "7750c74c31457887c9358e25059723502fb05779f7134a62a3c9772783111825"
    sha256 cellar: :any,                 monterey:       "00e8415229eb551b1fe0d2aa3c920f4ed73cb4577c5df21a623740a8b582c122"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b6609df4406451d64d41207c53d4fb159589089bfc970e0c17b6240caaa88715"
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
