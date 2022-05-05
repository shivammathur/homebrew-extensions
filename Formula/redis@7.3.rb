# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT73 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-5.3.7.tgz"
  sha256 "b958166ccda4f40bd17c6998f9e2239021ae644467cd8ad5c15def420aad65b0"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "6415add8b19a1f68ddf95b53b7f6a20eea64fd5467d539206b6e5c0957178783"
    sha256 cellar: :any,                 arm64_big_sur:  "8d4828df182a4d6340597563ffa0ae953ccac34a2cff24c54153dae60f3c8bed"
    sha256 cellar: :any,                 monterey:       "b30a767010e47e9b6d93ae54ec0353df86e322c9d8cd96d563178f4516b6ec6c"
    sha256 cellar: :any,                 big_sur:        "02f01018e7bd9b7a06ecfb9a0fb31a798cfe5220e11dc015d836d3773da9ddd2"
    sha256 cellar: :any,                 catalina:       "33821fb87daed5fd2e0fc553c3718025c7dcd9ca19d2ec5f1cfea0db97ec9a0a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ad1e6c4e2f6a77ade376a1e4388d220abcd8dbfaefa6ff818b45b9f10cb37209"
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
