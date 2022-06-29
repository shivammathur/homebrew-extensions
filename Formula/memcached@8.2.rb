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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "4f35d19cd19cdb6b8e98468a8880bc05fade82230a9aed1c9361307862096598"
    sha256 cellar: :any,                 arm64_big_sur:  "b521420362d407fb43bc30842c364c741822f791467883f837e0a4979bb77b7c"
    sha256 cellar: :any,                 monterey:       "a53be70e07b9aa637fb6e6ee0efd5a1fd1ede60d3f679c282688cfdef6478059"
    sha256 cellar: :any,                 big_sur:        "8733846683343900a651c453b9c236c516675fd069b6304ecc1e368db547a9e4"
    sha256 cellar: :any,                 catalina:       "b750abda2c56df1cfc5709df6c2981c37d5317a563b8d5b6b8abf7e2fd481fbf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eb732f94f53407b5d0d52f461c3ec9a15e73f12231a040a7dacc7ccff2608d43"
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
