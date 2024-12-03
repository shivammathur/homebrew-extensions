# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT82 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.1.0.tgz"
  sha256 "f10405f639fe415e9ed4ec99538e72c90694d8dbd62868edcfcd6a453466b48c"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "b1bd3541b900869495e05150c8d0b3b5e5786d4c96c541992b7f80b73a913e14"
    sha256 cellar: :any,                 arm64_sonoma:  "962349d6d9adf1ba4441af811168b7dec96b962b3d2dc523a5895256c4df74c4"
    sha256 cellar: :any,                 arm64_ventura: "964074e207095e16de1f04146d5008e83c119d5592addffcb785081b237b9ef4"
    sha256 cellar: :any,                 ventura:       "8f281628c1aa5ff03a37c250c90332132547d0c24f697205604f0f61a55e0fea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "00d5fb8a049190dcbeeb31286fe6449d68c46b8f3a800e6d1c9865b85a486799"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.2"
  depends_on "shivammathur/extensions/msgpack@8.2"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.2"].opt_include}/**/*.h"]
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
