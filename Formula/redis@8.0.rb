# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT80 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.2.tgz"
  sha256 "01aeccb0e14f897fe56f0509be6e6991ff0ad459f9d34e95e4556d02699b9a03"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "3f108ef603933c9af826dd9c58fbd551986a3fd345957a745571e95b5d065c37"
    sha256 cellar: :any,                 arm64_ventura:  "7ea89d9dcac7c80a6b9caf30aef8c10ad497a18c84b8d4c9f1c05620c84ebca0"
    sha256 cellar: :any,                 arm64_monterey: "3cf59e47326d78b905fc0c2fdcf97ff9e6f11660ae72484c8420797fae99c67e"
    sha256 cellar: :any,                 ventura:        "68b0d28bd333fdc78f89ada907f9073ddf3324b1e15ff10a2a203afb32cc8e83"
    sha256 cellar: :any,                 monterey:       "7c526f282acfb069a72898b04d43f608452d4b87ef0a4f8c4ed4e74faf57e87e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c8723b4f5c10591a78022bf9df24d6a721b1360b8add7600fe8d3e6265deb5fc"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.0"
  depends_on "shivammathur/extensions/msgpack@8.0"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.0"].opt_include}/**/*.h"]
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
