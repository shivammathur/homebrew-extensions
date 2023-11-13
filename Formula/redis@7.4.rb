# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT74 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.2.tgz"
  sha256 "01aeccb0e14f897fe56f0509be6e6991ff0ad459f9d34e95e4556d02699b9a03"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "c35fd6e72bc75d6195646f96f472bafdad97c01da57a7293d7eeeab0f76a7175"
    sha256 cellar: :any,                 arm64_ventura:  "4001f5dd97e5dc65b4b480d3295e0b034ee934941d3d036c148d620e595aeb93"
    sha256 cellar: :any,                 arm64_monterey: "b1c1ad42441c38579022f81d40262c6c52845caa6f751390002c4d8dc62a3aa3"
    sha256 cellar: :any,                 ventura:        "c16c34a8b4d6eb94483ad51340151e351ac060ca893172e3c5ac818b8ad3510c"
    sha256 cellar: :any,                 monterey:       "73149f95e425323712c36db4adbe1771fc605b51bb52502d08ecd33667f5051c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bb96616d8b0ef9a15b520bd270d041543d1fdbfd18b6246ac869002fd2bb8004"
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
