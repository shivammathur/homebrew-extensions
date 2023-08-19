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
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "8d1fbedaad8d5412609327bb68f32b0b5dcb2206b06cccbaf7e550523896c9ae"
    sha256 cellar: :any,                 arm64_big_sur:  "c226db04d98093c05db7d566ff67e6e314e7c89b07cea956fd3b01613b0ddb85"
    sha256 cellar: :any,                 ventura:        "18d71d3be5354d4ac9fe46175bee4aae22173268f0b3d7d6ad398430445809c4"
    sha256 cellar: :any,                 monterey:       "ceadd24a9f22267077d5124bcb2163fc08f4dccf521e48c7fe834a73c973a4ab"
    sha256 cellar: :any,                 big_sur:        "52e568c5d70e038aeaba23f529fe223a8f08a14c95436e570c720e05ea6dc0af"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c6e2914b219c18bc771cb957aeb6a18e9a5ef897928227299679bf8a2de8e24b"
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
