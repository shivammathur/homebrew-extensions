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
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "377b53689677139872a7d6600a24f4a68b57a0b9dc8b8a2e4c8c08612e320124"
    sha256 cellar: :any,                 arm64_big_sur:  "6261e3fb35fbe722a45e2c7af4d2ef94a8edab89f64df8ffdca0e9aeac34475c"
    sha256 cellar: :any,                 ventura:        "7121220a5e79a7807f18e4fd1d1b0cf44b4286588d28bb5d77f11d4fa908e4bf"
    sha256 cellar: :any,                 monterey:       "2164f92b590d118196c3d37ca80526b9d1b0bf265c5d93395da8de5e180d3182"
    sha256 cellar: :any,                 big_sur:        "a5caf86f1859bab7052614f7b51a5069c4151f3ad46ec20072912d67452ea426"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3f57b39a9b2af9090a97b44660ab3bc4bb5e0f9a480d034254fd06d25dfadfee"
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
