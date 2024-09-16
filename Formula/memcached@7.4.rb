# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "79cb4ce16642e0092e3438e2d51216ab34a80802ae0c2a4ba435184ae21a5264"
    sha256 cellar: :any,                 arm64_ventura:  "cc8389bb54ff47d11670bda311320ce04491d67f9645a743ccb796bdc00047f9"
    sha256 cellar: :any,                 arm64_monterey: "6ee112c06e7c3739684e8ac0320a8ccc46c64dce3e9f5d403d38f8baaba5767f"
    sha256 cellar: :any,                 arm64_big_sur:  "b2bae990747e82d2512e7165b5bf17c0d58d90e9c85c57db57e9b5f93bb38edd"
    sha256 cellar: :any,                 ventura:        "0a9c95c42c84d76637322f4f3a6899ce8982c981dacac331f3aab57f6a9999f7"
    sha256 cellar: :any,                 monterey:       "2e07db234ecc5e073f7e00b2fdacbb4793bf46f894ed07887be819a767a35991"
    sha256 cellar: :any,                 big_sur:        "016fd3d3b9de9f143dd70c88bbfb2680cad61c33a5d01691e6e36c5bf66da2f2"
    sha256 cellar: :any,                 catalina:       "59d230a5772c71fc16f6d02e96569b5bcd520352ce0609a624fb2bab8721a34a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e93bedf7125564b0479168012e73a39f8564a2d4eae02e1166179929067341c1"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@7.4"
  depends_on "shivammathur/extensions/msgpack@7.4"

  uses_from_macos "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.4"].opt_include}/**/*.h"]
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
