# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT72 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.1.tgz"
  sha256 "d39136e0ef9495f8e775ef7349a97658fb41c526d12d8e517f56274f149e1e4e"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "56ae877de51c09de151e6f04fb13a960443da8f3be66d29af058f7e210fadac7"
    sha256 cellar: :any,                 arm64_monterey: "91c4397e3b21eca69e379b7c48d6aa3cb2aef5e3f87b98364bec15a9d4300394"
    sha256 cellar: :any,                 ventura:        "7377e4b3e011d9ef2c48a5b2a10eb5bc09786100aba709e6fc37a002ac73993a"
    sha256 cellar: :any,                 monterey:       "476c7abfa4a068e5fc9f982e729fe2826cba1c7efb517715be2a21d6f30db7e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4bef46bd7f677fe1cec3aed0f55c36b45bd812e93716944cabd8aae15dc1d9d6"
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
