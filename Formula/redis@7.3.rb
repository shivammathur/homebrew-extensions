# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT73 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.2.tgz"
  sha256 "01aeccb0e14f897fe56f0509be6e6991ff0ad459f9d34e95e4556d02699b9a03"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "789ce86d098bc5dc2cf317e4b1401471290ed1ccbe9cb0b845ce8841d055917f"
    sha256 cellar: :any,                 arm64_ventura:  "7d54c0b6682eb043d633d9e8d5c448439e18be2fe027c92702ecb9463af0f3fb"
    sha256 cellar: :any,                 arm64_monterey: "72f9dc849ac3913c41adcc968513ba08b46a32aa4de1e29620ec8fe0172ad124"
    sha256 cellar: :any,                 ventura:        "b79b52499dc668e4fbb74d32dc7ba79d51438afeadba9e8f276277dbce361815"
    sha256 cellar: :any,                 monterey:       "1d001f729f01f7cfd5de48d212891de8e8939ac6955f64b60434555c9dd039c6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "88c69b0ef6c1dbfefcab6e886a0da1c6c102b5542507a89de8b798654b5fceca"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@7.3"
  depends_on "shivammathur/extensions/msgpack@7.3"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.3"].opt_include}/**/*.h"]
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
