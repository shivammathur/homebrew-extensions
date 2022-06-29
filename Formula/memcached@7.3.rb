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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "492e199348ba27ad374f0e27523248f9478157893df3c6144ceaab6a0895f7da"
    sha256 cellar: :any,                 arm64_big_sur:  "8300d80e683a7509adae7e4be93f99bd994cc1e05bedd9bb00eaa919344e4eb2"
    sha256 cellar: :any,                 monterey:       "eb076e9d3cf1114e41fed228b2b8275e4c9d3805a27e4aead0b0c49df5ff7806"
    sha256 cellar: :any,                 big_sur:        "cca94e5096cb9e8fe518e02ac0d0657d997e2eeec322ac3661e2bec1be0bbeb6"
    sha256 cellar: :any,                 catalina:       "4c2efaba5c52600b452ff5cfb588c3828fddd67cdb381c600c4715b0f9d4d906"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ee99e9b9fcd57628ca74c1a51d439dbdd319cfe00662a79584798bbc5c0582c8"
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
