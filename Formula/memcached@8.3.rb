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
    sha256 cellar: :any,                 arm64_monterey: "0cf6f67b277c7d2a4ff8741966391739cbc32026aeb0fcafe2a5269335d9bd85"
    sha256 cellar: :any,                 arm64_big_sur:  "642a25933f7956a706089965c1541537b4f8e32dd7d5ebe4653c189d33be4b69"
    sha256 cellar: :any,                 monterey:       "3f92bd3f1f25b2732c4cd0a9b25adfcf1f48f6cd0cc33bd8090d915e197908d2"
    sha256 cellar: :any,                 big_sur:        "327cebf58e6a19ba9d1b12bfd3556562d638493423f7091542a46e2d33502ea7"
    sha256 cellar: :any,                 catalina:       "e6fe49a789ac9b6c99e0444eba7ff169b4ebfad62ebd0bb248beaff38f9a19a2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7d0ded2cedc58808b206d4f457912863a56869877fc39bcd8f9b1d9882505863"
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
