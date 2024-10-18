# typed: true
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
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "34266eb7a876994733d83fc1f8ee1bab42774731fc662396f7d5af39a405550f"
    sha256 cellar: :any,                 arm64_ventura:  "91c9a883f2cd6097d2df0414c562722c273524b38eb0464578300202d3857112"
    sha256 cellar: :any,                 arm64_monterey: "af7cb22f4ef885a2ba81bf191c4cef9e83432cb8fa6e812b6d544e212277152c"
    sha256 cellar: :any,                 arm64_big_sur:  "3e9b80746f0991a7b4feacae28ac0178769283f053701eabb38d3b3b2d3d66e1"
    sha256 cellar: :any,                 ventura:        "9d16440242b1e611d28392f8dbb7e60b19e34ff7ae1ca5c004aa5c335ab28119"
    sha256 cellar: :any,                 monterey:       "ee84adbca2e89ec7ac5cf83fc4fa6539b55f6cb452c780a3b0064cbc99ac8697"
    sha256 cellar: :any,                 big_sur:        "d2e04bfc63ed8910390c98fd38e7b080a4460743679b1bbae31aea3939fe98e1"
    sha256 cellar: :any,                 catalina:       "e693188f13c3c00c885a31712b0f8737e3eb662f9875d65dd917b41e1efb4a4f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1d1b244579cdeb025252bbae1e9d3cb6b52c26f9a9c2b3de89bc273e9d1c9157"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@7.3"
  depends_on "shivammathur/extensions/msgpack@7.3"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.3"].opt_include}/**/*.h"]
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
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
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
