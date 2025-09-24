# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT86 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.2.0.tgz"
  sha256 "5069c13dd22bd9e494bb246891052cb6cc0fc9a1b45c6a572a8be61773101363"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/redis/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "2cb1b1e93b68ab65e32f729a5274912a8b501e13b466ff0148442cfd86a0337f"
    sha256 cellar: :any,                 arm64_sequoia: "6902b53bdf5c7bd6e66be949154244c21fc348f20a863f5351c1f9bc1a25a995"
    sha256 cellar: :any,                 arm64_sonoma:  "ff3d1b3b6bd96728dd17beceef347ebd9f0e98e30abd1a2d7b8c27c64ba5ba6e"
    sha256 cellar: :any,                 sonoma:        "6d2d34d4868887219c8d5cef6f7bb3ee165f1bc33ad34b5e73f99fbd3ef112b1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "77fd18ebb30a68bda367ecc9cd825a4879a39ae7e408cad2c5a5f30e60072950"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bba90f65ecbf80ef4a1a37a8c8089b3b8260c9911da1212590cf9a2b9322ee0b"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.6"
  depends_on "shivammathur/extensions/msgpack@8.6"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.6"].opt_include}/**/*.h"]
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
