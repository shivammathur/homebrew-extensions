# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT82 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.1.tgz"
  sha256 "d39136e0ef9495f8e775ef7349a97658fb41c526d12d8e517f56274f149e1e4e"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "a9ca74eae67717af3a29b4c4be148d380d230fc83ea1f2436f6ac2e47ca3e390"
    sha256 cellar: :any,                 arm64_monterey: "a7c0257e90096cabe2fd65d17b06e7065b06c526f393e3fd363fde42eeea40ab"
    sha256 cellar: :any,                 arm64_big_sur:  "71f6c8894bbb8435eac8ed8d9ec3180e1324d0c4c4b4aabaa96e89fbb919fdc5"
    sha256 cellar: :any,                 ventura:        "4bcab51f724b8d255996ead710909caee53bba76d7cf56768404c3d352c9ff74"
    sha256 cellar: :any,                 monterey:       "67860304dc0b6bf93e9fa96293041cc97991418f7a1c73f1cd72cd9a5e808d9f"
    sha256 cellar: :any,                 big_sur:        "eae4395e4528417cd0c7a55a7c6a7b2a4bfa70ddbbe380533ebbb61de8009afc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b58b6ce0ada2dc388a74df37711c8eae39efde0b8ed51ebf865ef3d37635b0af"
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
