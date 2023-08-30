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
    sha256 cellar: :any,                 arm64_monterey: "b65294486182095dc23b2970e4e6e3ff07ed620320cbe867f6968c9646044f62"
    sha256 cellar: :any,                 arm64_big_sur:  "e9ce8a09d08435493c498989a3510f3643bc187398c04b205353dea7077c4a67"
    sha256 cellar: :any,                 ventura:        "ad43d9a638752cb1f7a01a094a991568b4c11b404c24830b50485b228fe84e75"
    sha256 cellar: :any,                 monterey:       "cd90a23d294dfc931451b5259188b52a3a33e55615df9647bab4ea6276842a8f"
    sha256 cellar: :any,                 big_sur:        "eeb76da3f422768a007c51cd132b87a6aa72dbe0cf11b76deb798d23860f7146"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1758d9e44b3c8b84c2072a49adae359eb103a85160da7200c38bdb0d9251aed7"
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
