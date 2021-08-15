# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT56 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-2.2.0.tgz"
  sha256 "17b9600f6d4c807f23a3f5c45fcd8775ca2e61d6eda70370af2bef4c6e159f58"
  head "https://github.com/php-memcached-dev/php-memcached.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_big_sur: "640e31e897e82e8abc201cb31faa0807a5c1d3e1b1b8b2fb3f255d9b6cedacbc"
    sha256 big_sur:       "6d9f00d588706ad361c46ebd028a752e7e51146b6caaec8e2cdb5ee2af06d741"
    sha256 catalina:      "89ec4e27957c3dfba1e7f2c5bc442e474f5a194eec9ab70293a9fffd64062b57"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@5.6"
  depends_on "shivammathur/extensions/msgpack@5.6"

  on_linux do
    depends_on "cyrus-sasl"
  done

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@5.6"].opt_include}/**/*.h"]
      (buildpath/"memcached-#{version}/include/php/ext/#{e}").install_symlink headers unless headers.empty?
    end
  end

  def install
    args = %W[
      --enable-memcached
      --enable-memcached-igbinary
      --enable-memcached-json
      --enable-memcached-msgpack
      --enable-memcached-sasl
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
