# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "4cc27dfd04cc6330afc3dc89c1c288b7c62f897eeca5cf44c7ef0aae0f3068f4"
    sha256 cellar: :any,                 arm64_big_sur:  "f57adcf804631747de2daacbcf632c2966ea56afb48c38c19b1e72a2f285b8ea"
    sha256 cellar: :any,                 monterey:       "fcc4a20a3632de5510e29a6fd24681580f5e21ab3934d68b43bdbbbace5a20f7"
    sha256 cellar: :any,                 big_sur:        "e2009332036e9481bd1e1f410534e6a1fa5dc028c638e7283f64751deec5d6a9"
    sha256 cellar: :any,                 catalina:       "ef8a74bd91f5c0ef6ba2f624391469daf4493a0cf878af84f2a600406ac48a19"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ce5431d5478ae0e7660f99a29ca154a1352d6a34aef34ddef1468cadb4518948"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@7.0"
  depends_on "shivammathur/extensions/msgpack@7.0"

  uses_from_macos "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.0"].opt_include}/**/*.h"]
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
