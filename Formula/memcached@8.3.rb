# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT83 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-3.2.0.tgz"
  sha256 "2a41143a7b29f4a962a3805b77aa207a99e4566e2d314ce98a051cd24d6e9636"
  head "https://github.com/php-memcached-dev/php-memcached.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "1ca9b94d4ded150016309ed446e073c68c4576b8585bfcba738ae64b99e657ad"
    sha256 cellar: :any,                 arm64_big_sur:  "cb906980c0c96c5ac5d21956e30f7522c2533c55ca3958080086a6369499544e"
    sha256 cellar: :any,                 monterey:       "3ce6698f9e87f5262a35e6983cdbca99ebdcd87e352f7028e68947a4569e295a"
    sha256 cellar: :any,                 big_sur:        "70286fc971772aabfa01e3ae73d8cf8e9da7e04218cc8f43d4c47222a0385a45"
    sha256 cellar: :any,                 catalina:       "471ae7b35709572947a8171dce80e1a5ba1e94a6cb363bdba256743eafff57ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fe378d64cd746f65983432ab6cf6cdae5e0388cfd69c224f140ed08d374ebe97"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.3"
  depends_on "shivammathur/extensions/msgpack@8.3"

  uses_from_macos "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.3"].opt_include}/**/*.h"]
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
