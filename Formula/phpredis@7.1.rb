# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class PhpredisAT71 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-5.3.7.tgz"
  sha256 "b958166ccda4f40bd17c6998f9e2239021ae644467cd8ad5c15def420aad65b0"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "23275230c5f524c7fd830bb583bf916c54fa3f5afc33826382cbc404d847a876"
    sha256 cellar: :any,                 arm64_sequoia: "d29dbfd12a89434fcf2ce22abe31efc123bf393666247f5f8b91b16a679120d9"
    sha256 cellar: :any,                 arm64_sonoma:  "cd21dc31684caf01a8c639e1407c9bbcb4dc8388687e221fe329b22624d4d405"
    sha256 cellar: :any,                 sonoma:        "1b48d7aa3140dbf3543085a823ae4b5a2c141654d1d02df8d5a6b632d8b27689"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8bbf6d7cbc03002bdcbb527101ee61f59156a809765529bb06013cee62bb6995"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2c388eb4582a1380c41a7d28e99afecdd6fb19fa35ea336df444f502169b38a8"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@7.1"
  depends_on "shivammathur/extensions/msgpack@7.1"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.1"].opt_include}/**/*.h"]
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
