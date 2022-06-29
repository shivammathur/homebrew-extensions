# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT72 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-3.2.0.tgz"
  sha256 "2a41143a7b29f4a962a3805b77aa207a99e4566e2d314ce98a051cd24d6e9636"
  head "https://github.com/php-memcached-dev/php-memcached.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "c5fd1770dabdca29a0d175bf70e9b59711f80d108ee53767cf738110b7a1fd98"
    sha256 cellar: :any,                 arm64_big_sur:  "7eca1124c7e29c67f34189b76dbf28bac226d3bd0fe9a968e13afa79c7dc293a"
    sha256 cellar: :any,                 monterey:       "57fe99d81bb463802f60be906e0c772056b9868a24648472862aab6768d5c9fe"
    sha256 cellar: :any,                 big_sur:        "902788a369f81d9695bc4ba0ca3cf000e2b186f3a30c78951af5c61c0282e2dc"
    sha256 cellar: :any,                 catalina:       "cb206eaf34ead6a0a1953b63b16fbcf7b8748450ccd5e47aebea09ab26004fa5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "053d417a8682da189b054130023b59f1ceac5711f83ab2d5c563ac10a602450f"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@7.2"
  depends_on "shivammathur/extensions/msgpack@7.2"

  uses_from_macos "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.2"].opt_include}/**/*.h"]
      (buildpath/"memcached-#{version}/include/php/ext/#{e}").install_symlink headers unless headers.empty?
    end
  end

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
    patch_memcached
    Dir.chdir "memcached-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
