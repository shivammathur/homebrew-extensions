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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "c386e9c2d467a48f7bff114bb62b56e267205eab1ca3a1cf7d34501d777eb7ff"
    sha256 cellar: :any,                 arm64_big_sur:  "12255390d096f1b3b2a6a924ed42e4e3a915581defde8d1f31894f01ea303106"
    sha256 cellar: :any,                 monterey:       "a45a8c76322f3fa9fd2769b4dd8723dae3dba9432263964af8398b0a9c87bdcd"
    sha256 cellar: :any,                 big_sur:        "ff1d0e19de1eda03abd42afbf3e348e863d5c4efb47cbab54588824fa032cf48"
    sha256 cellar: :any,                 catalina:       "161a94b1414aefb30c9cce407eddee4ca41a50b71ce0e1e7812e6c78efbdc2ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "76614627c7d75f44f57c3bf821453d82f4772b092868767e7c1ee317251ae2d6"
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
