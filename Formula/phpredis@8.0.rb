# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class PhpredisAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "a5cab2d38d2ad20ebf23a218dbf36738431d73389c54406aeff882e778cd6e31"
    sha256 cellar: :any,                 arm64_sequoia: "30995816a6f74020f1f8b9889e540e50ab20dbc82dca7c3b2f279dd5b8165dc6"
    sha256 cellar: :any,                 arm64_sonoma:  "979b275604dfd272f1bbd43d658f86af2cb9a7606bfefa6ea74e268d7fc33dc1"
    sha256 cellar: :any,                 sonoma:        "85ddf92b99748ace3a258f498e3059249f59dfb448a02b483d043d727789337d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f248a4a4b2f7ac38447e9e61c2e30573cdca77b241adf1ea4fd5cb74b31ed6e1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e8b14e7847bb50857d522c42a4936444193573ed0a7912f8dde274ee3f8daaa3"
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
