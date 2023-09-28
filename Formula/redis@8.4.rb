# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT84 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.1.tgz"
  sha256 "d39136e0ef9495f8e775ef7349a97658fb41c526d12d8e517f56274f149e1e4e"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "8b3c0f6ec7d6f908dba5d614469e147874d1dac27ca0f78bb3e8986897945979"
    sha256 cellar: :any,                 arm64_monterey: "dc5d2720f0984c170c600b351d98c027ca8a7a8635c4901892a14d289d0daf55"
    sha256 cellar: :any,                 ventura:        "3076252fe5dafad575cd2f1ff4bf6200f14facf9dc0bb9029d6f1d1295b855d4"
    sha256 cellar: :any,                 monterey:       "08eed5657de66bb98e852f791a79372d0fd3f806522da56fc895423f06ce4c88"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "64e65da517ed950318e3eb17e65ba8e328873e552ef92e6ea7988ff02d00dfa4"
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
