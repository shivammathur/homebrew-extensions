# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT71 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-5.3.7.tgz"
  sha256 "b958166ccda4f40bd17c6998f9e2239021ae644467cd8ad5c15def420aad65b0"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "a0c0e1fb0382c515def3ecf6e678459267857fefb318677752539db09c374db8"
    sha256 cellar: :any,                 arm64_big_sur:  "2d49a1e6f13bdee44bb57b7c15348bc94099a05677037fd2c236dbdc2f86a9dc"
    sha256 cellar: :any,                 monterey:       "b6ba79fc1078a825def52d69efaf3472dc7306ff476f6911edb096050a2e71ed"
    sha256 cellar: :any,                 big_sur:        "67058a3f5b9545b1b0370e748e28f3db9a231af8761dc4012a8738cbc1175ef3"
    sha256 cellar: :any,                 catalina:       "d05f1d126a2a7731224ea6032b1d0ccc1b305c6ab40cd00487a5473ef82175c6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7afbc8ccef1523eaf6eed49294bc6c5ddb2b7e19b809ee90f05f9497890db528"
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
