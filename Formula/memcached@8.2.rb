# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT82 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-3.2.0.tgz"
  sha256 "2a41143a7b29f4a962a3805b77aa207a99e4566e2d314ce98a051cd24d6e9636"
  head "https://github.com/php-memcached-dev/php-memcached.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia:  "1b0414c2aa3fa72177224a9ba1f5127559d59fffdb99b8e2efd5309f3b5e8f3e"
    sha256 cellar: :any,                 arm64_ventura:  "0becab49e6b04f3053bcab4f759ff595f78da87dd40c407eae26fbf794b0607f"
    sha256 cellar: :any,                 arm64_monterey: "87518cfdf878c8ec8bb9da3a524fcfc00902e805ae41045a7dd41c5397bbec04"
    sha256 cellar: :any,                 arm64_big_sur:  "fbe3f1b499e5673366e6701e6dacb381b82bb9608dc63316cea2db957cadb060"
    sha256 cellar: :any,                 ventura:        "1e24e8dccd3d2d6daba999277c3b20e68b47090eef9493331eb39c6dff4d1fac"
    sha256 cellar: :any,                 monterey:       "2fc1f7095eea72555c48ba7eab198b8c85c3275b50d9266e85ba5b147b924688"
    sha256 cellar: :any,                 big_sur:        "4f3777652c9d7d31c29f14ab0ee9d9656c11872c7cce7d0025b36507e5d5fe84"
    sha256 cellar: :any,                 catalina:       "667c73527dd33ad47635e40d4ade1b27c59277e3fe8b54bc0cacfcface9036e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "976f8195af36eca87ff5b06fee7c83f74b92a966a464c41ad5c278635142bf1a"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.2"
  depends_on "shivammathur/extensions/msgpack@8.2"

  uses_from_macos "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.2"].opt_include}/**/*.h"]
      (buildpath/"memcached-#{version}/include/php/ext/#{e}").install_symlink headers unless headers.empty?
    end
  end

  priority "30"

  def install
    args = %W[
      --enable-memcached
      --enable-memcached-igbinary
      --enable-memcached-json
      --enable-memcached-msgpack
      --disable-memcached-sasl
      --enable-memcached-session
      --with-libmemcached-dir=#{Formula["libmemcached"].opt_prefix}
      --with-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    Dir.chdir "memcached-#{version}"
    patch_memcached
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
