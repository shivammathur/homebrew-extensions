# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT71 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-5.3.6.tgz"
  sha256 "fe295ec26a25204e6c07e8d7144210f767bd7008858719da230409eb3f6f2e09"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "c56e4d96b42e94e55253025453718e87359ba955dc1fb4848def7a6ecc0cdf45"
    sha256 cellar: :any,                 big_sur:       "12229bbbb081655d34dc616a02bcfb0f2a324916a0569cd2b53077079da53bc3"
    sha256 cellar: :any,                 catalina:      "32bda2727908e5a18bb1b9a361344231489e511e17c9681c48f8a23b740ea540"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "953fe468bf1062a0008af4139f8b524a8f9f80617c78f564cc9fd87cc5bcea3e"
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
