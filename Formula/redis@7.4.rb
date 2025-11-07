# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT74 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.3.0.tgz"
  sha256 "0d5141f634bd1db6c1ddcda053d25ecf2c4fc1c395430d534fd3f8d51dd7f0b5"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/redis/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "394feb7005a1a4be366cce1c584747da76bdf50f91e96a1f83e1188d8fd8db6d"
    sha256 cellar: :any,                 arm64_sequoia: "b76fa6d2a9a344d89c6244ac43ac08fb55b9c3f4f082b68597dfa478db01f793"
    sha256 cellar: :any,                 arm64_sonoma:  "9f9514c571912f808a3073d9e155e3dc2710d4d1fb7cc3488d7666f819e9e543"
    sha256 cellar: :any,                 sonoma:        "327e3c47a04c5ca0584f216d26cd55c86177b6a1e2d926a8bf6d8f900656ea40"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "95dc165ab7d47c4bfc99a540f8a0911df5cbbcf43ba04039124bd111d0218dfb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "feb76eb363ca9d893e3470fd32d9ef72545ce0bfaf2b383480d145e952ee9810"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@7.4"
  depends_on "shivammathur/extensions/msgpack@7.4"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.4"].opt_include}/**/*.h"]
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
