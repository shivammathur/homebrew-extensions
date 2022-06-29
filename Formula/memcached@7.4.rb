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
    sha256                               arm64_big_sur: "b66f6c06b9b8c855963e2116b78ca37a0faa46150bf402aea3e48e5b93f3fb13"
    sha256                               big_sur:       "eef99710a090aac801b118170ef90b297afdf98e45607d72de5e1962a20c3039"
    sha256                               catalina:      "5c09d3b1d87a839398c83498a45e3ea0467793caeff2a984620bc90e13c8f44e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f30ccbf87b539d9093ba9267642c88fcbda6289a46ecbde33388e3f766572ce9"
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
