# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "a349f8a357a8f105d4fc50136242b210e0c7734a2dd109f7623d42f42d556b41"
    sha256 cellar: :any,                 arm64_sequoia: "fac4aa8a0be2535f38d61d7397220b7accf86fb4f73c308492a5aa8b9d68b089"
    sha256 cellar: :any,                 arm64_sonoma:  "6e2f2af816c1ed24a168196cbb08180188c8178e816b33a3de4919987aa65666"
    sha256 cellar: :any,                 sonoma:        "50b67a1f2d1b1149abc944beb8606937c138469bcaaac3f65a127c9b6e6b0a98"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4e43c8823d5b04bfdec5a0a8668d14b8b0b7b951ec837b7bffdce333fc224974"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fc701929a839826d6e180ad6575938013238bce57fe3292cdeac3efaa14d7423"
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
