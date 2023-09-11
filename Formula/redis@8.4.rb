# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "5db24a94c1080705a631638c9dacbaae65737e9be92734146ac06c52205bc7a2"
    sha256 cellar: :any,                 arm64_big_sur:  "6cc731c143c6dc898bacc35812fd7b32db2ea8488b0b354800f527ea8162c4b1"
    sha256 cellar: :any,                 ventura:        "fb171b7978fa7d75cadab3a4e9a75b001cbd5953553c8e890915303d22a7c66c"
    sha256 cellar: :any,                 monterey:       "fe5c796847313e950b9ad90be4d8a37d170babd00f0f2b6517fa1f47534767a9"
    sha256 cellar: :any,                 big_sur:        "c88c648834699ffdb9c3c6773592573e8c9949372e66dd8589c8d096bc77d5f3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "36f40dc91165e5fe3359a95499b0c650b5043b773b548cecdbfcd8e68ab5b75d"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.4"
  depends_on "shivammathur/extensions/msgpack@8.4"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.4"].opt_include}/**/*.h"]
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
