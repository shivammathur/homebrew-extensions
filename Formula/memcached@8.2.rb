# typed: false
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
    sha256 cellar: :any,                 arm64_monterey: "82b291220e7b9964e998d4f88fc2d4e14692454c74cedd72bb083c72003bfaae"
    sha256 cellar: :any,                 arm64_big_sur:  "c2e90f33ca1f8159e7db7dfda834c62ffc79ed504e8508e644a94f1014092d85"
    sha256 cellar: :any,                 monterey:       "67f53480ed4def6877743de5c892b475ab04508a4b9151b04af202cde20bd732"
    sha256 cellar: :any,                 big_sur:        "07a0b8a3556a22e38918dbe12fa344f123949f96556b4321f2e36e51bca361de"
    sha256 cellar: :any,                 catalina:       "4fcc17a663e2b2114594784943c078427d91756cffec8b3f445b82168e251948"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d9d38a1186b94e14ab4f4f1d52540feea0b117f0412db3d3c73eaed02270515e"
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
