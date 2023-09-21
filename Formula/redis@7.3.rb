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
    sha256 cellar: :any,                 arm64_ventura:  "cce706012123d9a18f1c289ae128e841b9a60858660000df7f0bc8dea4efc9e8"
    sha256 cellar: :any,                 arm64_monterey: "8f8dacc642f68845ab45b65bc18def2ede888d629905f010b7ddaa1a42b26d50"
    sha256 cellar: :any,                 arm64_big_sur:  "64a2109136c8e5f78a2211ee33bc1da4d95ea9a22185519dc360286153631548"
    sha256 cellar: :any,                 ventura:        "f3a48b08a7108dd2026c2f0ec9e97962ce15af0076c98382e277589abced5b88"
    sha256 cellar: :any,                 monterey:       "2f50f7269cae01d0b267f9d0036ec715ed049c2693810a264bdd9772a36b781a"
    sha256 cellar: :any,                 big_sur:        "451d54ca11fa12dcb270b262f411efc856516c045fdbe4705b8afe4937a7ba3f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7d5653a832323f00bc32a6f634d5de0ccb5a6f1fcd334187d8366d3a3693890f"
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
