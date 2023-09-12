# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT80 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.0.tgz"
  sha256 "901d5a0e52236c1c885a6c970870e089ea46de41d9027a92b6a9bad26ae1cdfd"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "ef59fdb51ae41c995ea022d9bd5602b7eafdd6aed1aa3771a4b51daa64857123"
    sha256 cellar: :any,                 arm64_big_sur:  "35284e2323e6a4c7344211e4351e6c6388bae319fee58e37b27bb90e28e5a260"
    sha256 cellar: :any,                 ventura:        "718505ce24058c57970b1717ce0895dff16e93c21b4f6b8fe0a7bca852f32560"
    sha256 cellar: :any,                 monterey:       "7b8da327fd00d7fd4ab133353c6fcfeee847f3ad0568f09008e6e3685568a17c"
    sha256 cellar: :any,                 big_sur:        "3c9d4a3ac119cfcffed70e0c708a1f102831fc05d3dc31afa04d808dfe4a79a2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "527f2170226d4b5cbafe5da892c4f4fe57597e9306ee028869551453f52f7118"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.0"
  depends_on "shivammathur/extensions/msgpack@8.0"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.0"].opt_include}/**/*.h"]
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
