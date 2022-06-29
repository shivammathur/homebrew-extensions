# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT71 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "648f4f3eb5c352b6d578f0bb94cf5babb26b0cef453b5e53935e2bdbe75292cb"
    sha256 cellar: :any,                 arm64_big_sur:  "ee65692b8a7b0786e79ba7bb1be80b2f5bf10719b146af4f906f87c5d413a425"
    sha256 cellar: :any,                 monterey:       "99747396045f64608726ea3628c8f3158b3b74e73b3b66b2bad67c65e6df0e0e"
    sha256 cellar: :any,                 big_sur:        "eafcc3c7585ee3cbaadc158e2f1013c7c90a67683b1a66cfb8deaf3ba363301e"
    sha256 cellar: :any,                 catalina:       "1240a606db483147ffc2904d8dedfb616c729f17f25d56a1176abdd5ed9eb3b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "006a1de0bdffc4813ce8e9786918ab0d9c98973150adf5d568a7f3f2f14dcee5"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@7.1"
  depends_on "shivammathur/extensions/msgpack@7.1"

  uses_from_macos "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.1"].opt_include}/**/*.h"]
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
