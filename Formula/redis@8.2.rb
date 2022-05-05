# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT82 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-5.3.7.tgz"
  sha256 "b958166ccda4f40bd17c6998f9e2239021ae644467cd8ad5c15def420aad65b0"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "3ac7d61eef9097e602eea093debe4a8b19809c14df98d8924507808acb724f59"
    sha256 cellar: :any,                 arm64_big_sur:  "b4eb950f70b65a72517ecd0275152f7e0e2fbbb74b76301562f2c2e643de8110"
    sha256 cellar: :any,                 monterey:       "087093f1294defe71bc9b945caa1557c6071e55dcc2021ae2995c4f288eb9015"
    sha256 cellar: :any,                 big_sur:        "09f7464612ba3e10a7fa6b2dcfd8f3b7c7b5daf7c2f4a0657559d44de80879d3"
    sha256 cellar: :any,                 catalina:       "3e96848deee8e8584ed5ac01f9212fcf1bc9e401eb91d523a626bf8347944696"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dbaf2da2bfe2bf6cca59a3d0a779c5247bc8481b232d8e9741b50cb16bb8d0b5"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.2"
  depends_on "shivammathur/extensions/msgpack@8.2"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.2"].opt_include}/**/*.h"]
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
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
