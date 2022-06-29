# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT80 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-3.2.0.tgz"
  sha256 "2a41143a7b29f4a962a3805b77aa207a99e4566e2d314ce98a051cd24d6e9636"
  head "https://github.com/php-memcached-dev/php-memcached.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "b2629c672718faeb84c8d1ef481fba8b517d9c7b3f790af69cd8056e9dcfc832"
    sha256 cellar: :any,                 arm64_big_sur:  "13040fc660b776e4511162bb1d042e77f1575b0c85100f49eeef2e4423a85d71"
    sha256 cellar: :any,                 monterey:       "bca6f02a0a10fbc31792d2dccc0db9eef068d9e662e59f80bac374aaec6b070a"
    sha256 cellar: :any,                 big_sur:        "a07b667caa5d07d1405e0a2ec78761fe9588eb2f1d7882bd34fcf2c8524cca96"
    sha256 cellar: :any,                 catalina:       "e8b87f429119803a77c846e268180215b546efc96cb2e641decda4cb98ed3f12"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "583aaad9ed752910948eb48edd733e01201c0b29e581ed390992271d391cb52c"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.0"
  depends_on "shivammathur/extensions/msgpack@8.0"

  uses_from_macos "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.0"].opt_include}/**/*.h"]
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
