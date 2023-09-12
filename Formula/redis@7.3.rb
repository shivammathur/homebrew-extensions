# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT73 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.0.tgz"
  sha256 "901d5a0e52236c1c885a6c970870e089ea46de41d9027a92b6a9bad26ae1cdfd"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "87c0e32cbd0bade04a2e00eaa1f01fd3d913bac07080ea921dbbb916afa33135"
    sha256 cellar: :any,                 arm64_big_sur:  "fcf67e97b854bca86b0b2cb0af7e3df5b4ee1fecb85155764e5226ecdf3a7690"
    sha256 cellar: :any,                 ventura:        "b873d0329388ef9a4619d22f766d2b4f72e75974c17555f72eb7d9c2d468c7e6"
    sha256 cellar: :any,                 monterey:       "0d5272674f82ef92a21158fc364b49a62e17fc69e1053ddc8aac537e0dfc067e"
    sha256 cellar: :any,                 big_sur:        "3098a5cd806b235d2b3dbbfa1b09619ff6c3490b0cab596a388f61416d2b056f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b7f542ae69834b2af7f4a001e3cb405688d9b712611d34f04afb1af7cd5010aa"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@7.3"
  depends_on "shivammathur/extensions/msgpack@7.3"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.3"].opt_include}/**/*.h"]
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
