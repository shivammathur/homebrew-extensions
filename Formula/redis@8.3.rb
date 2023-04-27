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
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "7b7e101fb787b8ad0ad1e23c57f3c9404a05c9db4c68da126cffdf0d63c3ce11"
    sha256 cellar: :any,                 arm64_big_sur:  "425c062f8720985609e6e75a9cc7258a0445b8d097b22a85730523a6d0289699"
    sha256 cellar: :any,                 ventura:        "e1fa7800f23dc8041446f7fe36c07e60523e01699b7bd52f7f5510ad12b81ece"
    sha256 cellar: :any,                 monterey:       "903eecffb8b2dc86804ed0d972157ec6e76baab8d2ebf927c5ed39bb4f357ba1"
    sha256 cellar: :any,                 big_sur:        "bba9fb016fb7aca9bf34a05dd9a63e3eeccae98ea599d000fd40059b03be44a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4436347f8e905d99da7b2bee243ef87e3ede3121d3fb236bbda3a695085c13ff"
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
