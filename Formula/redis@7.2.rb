# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT72 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.2.tgz"
  sha256 "01aeccb0e14f897fe56f0509be6e6991ff0ad459f9d34e95e4556d02699b9a03"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "6c3ee96cc92e8e07048929f7df9eb4d66bf28aaca6fd38f7eff069ca214f6588"
    sha256 cellar: :any,                 arm64_ventura:  "7ba1eb98e7b67620e4b20a4000c97e45d9dc1a22a72faaf73106007dec4277ff"
    sha256 cellar: :any,                 arm64_monterey: "81924c84767d671d57bb8fb3fe935b7e5342c51071400ef39c2a6a802c636955"
    sha256 cellar: :any,                 ventura:        "a188da945ee93fff4aa7b6843f0f83d422ea89d4e476180cc8a44f676fb473fe"
    sha256 cellar: :any,                 monterey:       "3b39ffbcdedee89fb03b2cc89e0b014abe7272e915c1acb1dac9053b769ef23f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0b3a4fb5b1bff633b25435427360f8a37eb3af1ec7b5351817028a22939716c7"
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
