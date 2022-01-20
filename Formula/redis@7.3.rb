# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT73 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-5.3.6.tgz"
  sha256 "fe295ec26a25204e6c07e8d7144210f767bd7008858719da230409eb3f6f2e09"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "f29363fae860ce7d8896f2ac0a4bb1ca83e87fdd61ff9e0337bcf0189e890089"
    sha256 cellar: :any,                 big_sur:       "a39af79a883d949a4ebdf639beda5839f3a7bd4590462bf8a2ba96eca7bae1e3"
    sha256 cellar: :any,                 catalina:      "e9ddd48debc57ed933ba0dcf2383b1b9bfd1fb62012056f9a46179a9cac3e806"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "446552167af7c48be1a52e2748b15c717097aa4cc6dee6940167dfe618c8d2a6"
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
