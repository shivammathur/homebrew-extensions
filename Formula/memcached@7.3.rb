# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT73 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-3.2.0.tgz"
  sha256 "2a41143a7b29f4a962a3805b77aa207a99e4566e2d314ce98a051cd24d6e9636"
  head "https://github.com/php-memcached-dev/php-memcached.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "9f77cba82c8a6997b800bcb632a8b9f0d5a4957da6cb0e2b0d92bb72fa8c5f3c"
    sha256 cellar: :any,                 arm64_big_sur:  "d02f65a46a5ddbd9272dd0a2b5a99a4dd86bbc690ed063e1d85137a183adb36b"
    sha256 cellar: :any,                 monterey:       "f13d9f19a20a6b4c2115fb24e05d0c97b59c2a322e2475112e96666b4e8eb50b"
    sha256 cellar: :any,                 big_sur:        "0cad4afcb8134a8bc62080ceccb001b442a8a68f20f350f9624c13094edf4cd5"
    sha256 cellar: :any,                 catalina:       "8a12f6b4b3229fe34f10a2bbe1285820b525456897adff4c9b515978f137c4f3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "87f3665a9dfc3b6bea4cb01812aaace2df5b502ea18307a1fb136b2a4bbfa20e"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@7.3"
  depends_on "shivammathur/extensions/msgpack@7.3"

  uses_from_macos "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.3"].opt_include}/**/*.h"]
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
