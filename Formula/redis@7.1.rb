# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT71 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-5.3.7.tgz"
  sha256 "b958166ccda4f40bd17c6998f9e2239021ae644467cd8ad5c15def420aad65b0"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "80653c3ba1e5cfcbfcf54e95d8f15b24b1fb42b8284cc8bc8afffb6b0b075868"
    sha256 cellar: :any,                 arm64_sonoma:   "3af8a8cc7deffacc15550e10f1c5d07d6b1cb7279c34491fda8880b7a4d99fd0"
    sha256 cellar: :any,                 arm64_ventura:  "7309e81adb0b8f1fd8d74ae16184a0a36b154f5b9db99f5c5096a35151c34ff6"
    sha256 cellar: :any,                 arm64_monterey: "55c10c683f64895243354740ac350b3e7a09905910e2a0ef28e4ff8d9b93df0c"
    sha256 cellar: :any,                 ventura:        "eedabe6eb92bae007fa382c04934726e51b126f1c9da6b379c0657a8f4734a06"
    sha256 cellar: :any,                 monterey:       "133b17bb24252850cdf8d209ac615c422eebadadba57ce234a73b580535faf04"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "3c977c47177206b8a7edf1d1831b65abead7ed4614249ad7b357eea8a90651cd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2b9d0e73ccb43660ecf080ca94931fc5a921cfd28aa6c9f35dc7b1dc76015bad"
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
