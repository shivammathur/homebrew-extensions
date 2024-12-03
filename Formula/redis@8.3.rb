# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT83 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.1.0.tgz"
  sha256 "f10405f639fe415e9ed4ec99538e72c90694d8dbd62868edcfcd6a453466b48c"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "b73645f5383ee2c4b9e2f115ba1d5537b0f109aa414b193205d86dde7d359f6f"
    sha256 cellar: :any,                 arm64_sonoma:   "179d8c2e9729aa3368713d9a8bda19e31de10e62e3c1b2a9a63269cf69dbc81b"
    sha256 cellar: :any,                 arm64_ventura:  "3a109792fe8e930fb2f4e5a8a6f92409b077fe711a022b7a1c32e04f51bc3e51"
    sha256 cellar: :any,                 arm64_monterey: "74d3c962a1c927323ba0018fa1d6151e96fd3ad1d773ced66075f4f6d5c25f81"
    sha256 cellar: :any,                 ventura:        "27cd25ca4da325faa075fc088cc01e339ad92eee272afaa03acc8a0c15fdc828"
    sha256 cellar: :any,                 monterey:       "d642dda90f2a3adbb8d1b1bfa20293b6f9136b6ad9de5478235188f8cf68efd3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7e1242a95c39a4074faefe90db73121f108f340b4ab8b6e5c8e3e590f3cef825"
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
