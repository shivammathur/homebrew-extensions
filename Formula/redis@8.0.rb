# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT80 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.1.0.tgz"
  sha256 "f10405f639fe415e9ed4ec99538e72c90694d8dbd62868edcfcd6a453466b48c"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "c3a5256c0bbd03d7bd67f6b8a76452920be9c8859b24d02df1c4640ac67782e4"
    sha256 cellar: :any,                 arm64_sonoma:   "79ca4505255ff512c2157b51086cf64ffc46a98d0598c8f500cac48dccdc5322"
    sha256 cellar: :any,                 arm64_ventura:  "ca6622614f04c5f4a58bbdff9bd03e9848178e33b93c93d3cff233fcba094584"
    sha256 cellar: :any,                 arm64_monterey: "959e51408bd5bb2bc78def5ece83b532feb318daab5907c42fbeb4a0854dd231"
    sha256 cellar: :any,                 ventura:        "05c7e0f31a7e82a54c75ef39431f26a8199f1f22b42b5dfa79d66b0c183feafc"
    sha256 cellar: :any,                 monterey:       "964be1dba7b44dfc2cca154d42456f43d81590b8cb5f1b10d82960dc042e9720"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "caa360b51ea1130cd1ff088f7ec2dfa69475b0b27a198507eba03eccd0ef3f15"
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
