# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT85 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.2.0.tgz"
  sha256 "5069c13dd22bd9e494bb246891052cb6cc0fc9a1b45c6a572a8be61773101363"
  revision 1
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/redis/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "e17f557bad38c71c82990085ab5275776018a8b00ef89d5206809a2626b60bf4"
    sha256 cellar: :any,                 arm64_sequoia: "af6f2349b9df6fde1e39f85b4e87469eccdca40a19f785cc8ea7dfd2e809bf87"
    sha256 cellar: :any,                 arm64_sonoma:  "032d42c0970788ba54b2c7c826e2fca5e728db0e4ecfd574793db23df5e2ec74"
    sha256 cellar: :any,                 sonoma:        "e9f52f02d42aae144eda879202fd63145363caa65d17028d5a7f8e66f0f6dd9c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c6bcd9ef7115c6be26a1032db3a82354ef8a540a96d6e46fad6f46fdbeb5f188"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "76b0d723a2515f899630c73c614a24cef301ecebbe55919fe80bf1b409def998"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.5"
  depends_on "shivammathur/extensions/msgpack@8.5"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.5"].opt_include}/**/*.h"]
      (buildpath/"redis-#{version}/include/php/ext/#{e}").install_symlink headers unless headers.empty?
    end
    inreplace "common.h", "ext/standard/php_smart_string.h", "Zend/zend_smart_string.h"
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
