# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class PhpredisAT72 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.2.tgz"
  sha256 "01aeccb0e14f897fe56f0509be6e6991ff0ad459f9d34e95e4556d02699b9a03"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "d547e38287e008d5295bca67de388c5437491553a8f1573e203ed4061a6f3929"
    sha256 cellar: :any,                 arm64_sequoia: "5a0c233fd6e366e1151901b0accf6c7bce96671e1c608e06b73e403f73848254"
    sha256 cellar: :any,                 arm64_sonoma:  "440ef3985cfd8f5070e9a2629e92271272a974873803f82ad942da7a3ca992de"
    sha256 cellar: :any,                 sonoma:        "0cf6b67a37d0d33c68b34456281fa2a5a80835cfd342c4297243bb43f9f5e2b4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "aa0cb3f58ec70f1c27e0d351b57037a3512f4b3bfb1807bd13c173fb26fabf30"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1b5946ba78249395491ca742dcabc8b2a0c4b1e545e7d22ecad68b96b5fc1e3b"
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
