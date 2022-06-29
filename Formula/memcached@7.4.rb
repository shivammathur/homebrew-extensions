# typed: false
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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "15521cd97eee91549719774bfa32388c780bdf1d74efba9ce327d5c779344aa4"
    sha256 cellar: :any,                 arm64_big_sur:  "01ce144f0ba79d6c3c0cc270c6f9a29623ceaee7034801906b638ec18cbf320e"
    sha256 cellar: :any,                 monterey:       "428cb2202aa8f109f8c1602447e26b3f9d971f7bd0724b5b7b0acf1c16cb8666"
    sha256 cellar: :any,                 big_sur:        "302470834e3d34509df3eb08d48f9a1da2bef3dd8713964c988f97f6e8d067a4"
    sha256 cellar: :any,                 catalina:       "c40651e2e5fada33d3688e2ebae5ea861f18d83b7369aa4f550c8c3230d69509"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b04418b1ca91e5e90c59ec37e2c3a461d6a4d0a6e1fbd2429d7bebfb91dbabd0"
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
