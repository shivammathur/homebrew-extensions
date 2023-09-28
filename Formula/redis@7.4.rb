# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT74 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.1.tgz"
  sha256 "d39136e0ef9495f8e775ef7349a97658fb41c526d12d8e517f56274f149e1e4e"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "b678181c09f971fec08f68337dec49c291936131e9bf6d27d794ff6d35da8239"
    sha256 cellar: :any,                 arm64_monterey: "2f49defee6645d438f321dfd2b3d8c2690dc3de990277f59b9b4125ab5b908f7"
    sha256 cellar: :any,                 ventura:        "14e2e06c375da5a52616e717435d5d3a21d812b406a61f0c2c2db1f8abd14b22"
    sha256 cellar: :any,                 monterey:       "704f2c0bcb5a60c53b506494234217a27019b544c285019861f897e4494b45cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8dc0dce376194102483032e8e620f166d8c6a26208fe8bf8e30641b99fa56295"
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
