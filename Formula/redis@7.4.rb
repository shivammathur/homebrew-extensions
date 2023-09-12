# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "e3226440edc47bc65072f2794d96a8f7039b80a9d5e576f45041c41aef857ea2"
    sha256 cellar: :any,                 arm64_big_sur:  "adb9ca4d7c83005dfd63ec241c64900667fa33684c0fe07b68b060cf3e9c5db3"
    sha256 cellar: :any,                 ventura:        "380d9c7d15ffe47a5e023e780a071329bba99cfa26e323959eab606c4c01a843"
    sha256 cellar: :any,                 monterey:       "ddac86a6046803111cd45540eb24f5ee32fbc0bed4b0f9704434a09d38b9b5f9"
    sha256 cellar: :any,                 big_sur:        "9795942e09c559af126711cccb0d1a2df967ac87967edeb8f29c4ce4f33770ab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5f20dfe7f48b8e30910a6b64484d82ae22dc182a798ced26c8657c4f076071e5"
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
