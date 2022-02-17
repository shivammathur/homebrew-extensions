# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT80 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-5.3.7.tgz"
  sha256 "b958166ccda4f40bd17c6998f9e2239021ae644467cd8ad5c15def420aad65b0"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "95097625f62392c6e633c4136cb16f0aa388153375e720879275c63c2d5dcd8d"
    sha256 cellar: :any,                 big_sur:       "df446c46f704947aeecae9709898479f8f591d1abb961230ef236771f4295a57"
    sha256 cellar: :any,                 catalina:      "1e4bea34a8e990c4c0a62d0c13b8353ea1f9bb70a67e0b50d5744dc039da997e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "490e49aa0e12ebbf298c947bb2ffeb98cace70fc19e504e44b12c5b3cc8cc649"
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
