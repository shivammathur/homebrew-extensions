# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT70 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-5.3.7.tgz"
  sha256 "b958166ccda4f40bd17c6998f9e2239021ae644467cd8ad5c15def420aad65b0"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "b0bfea8dfda48ed39d99c29afb083189da495a3be7bb3b72b2d8559e0fbe0933"
    sha256 cellar: :any,                 arm64_big_sur:  "1abeb7d0dc356dbe4c9137eb57d8f41f5bacec7a373df2a2ad9d229e8ad00e90"
    sha256 cellar: :any,                 monterey:       "21a6178abc24c71a89d35ac36e0932cae6a5541bc8d57e30483935315ea306dd"
    sha256 cellar: :any,                 big_sur:        "52a321982ecb8bf16eb660419728ad221edd3feccfaf3a5a8d4ee0ef72ab6f6a"
    sha256 cellar: :any,                 catalina:       "bf6acf07f58ccd1419d5fcc1a53029ca8e56622477d7458fe335f28c0f77ba81"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cba66e4cbac16db98ca4fcb08b5ddc78f246745d64ab283afc57e449b9926443"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@7.0"
  depends_on "shivammathur/extensions/msgpack@7.0"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.0"].opt_include}/**/*.h"]
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
