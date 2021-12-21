# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT72 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-5.3.5.tgz"
  sha256 "d55fa5cc699198917ba2bdc827da632ad77f009ba2642d2750456a976dbe5989"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "76cfd16fa284d0f6568c647cd41654d2f0711ec00408ed0bd93870f0bd5e0585"
    sha256 cellar: :any,                 big_sur:       "6511ab9db1ab3b24c7b2ea2d2ec4d263e594f304afe661e4ae6898ed85ba6756"
    sha256 cellar: :any,                 catalina:      "2f560f2af6c53ad0b5a75831235ec30ec229ddaed7c458a5f2c9b60dfb539d0a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d3440cd696ddb079eb606b4120be39ae1ad6f95186697be9a58294176057b62a"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@7.2"
  depends_on "shivammathur/extensions/msgpack@7.2"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.2"].opt_include}/**/*.h"]
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
