# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "c734e648e5647f47394bd60138f97ad11db834b57e65fd5cdb0bd5d0cc498b73"
    sha256 cellar: :any,                 arm64_big_sur:  "b69673857ecd0fd85546c836e68e4bfde74284c0563d199881782f3af5c82b25"
    sha256 cellar: :any,                 monterey:       "75a0c7f3214ae12ce134abddaa6c7668c94aae80bf74f4a5ed8f524f472aec2c"
    sha256 cellar: :any,                 big_sur:        "89612aadf005fe5279e793088aa7f70776723342630c7ad4f70a0ac6ded07ff1"
    sha256 cellar: :any,                 catalina:       "0862a58b2e66eff87e6af8317905788f9d66abd49c6f8f31854296b3d8227942"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "344a12bfdf3856f4cde89d9ae67e819af5f2cff475a9d33259e642f81b41675c"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.1"
  depends_on "shivammathur/extensions/msgpack@8.1"

  uses_from_macos "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.1"].opt_include}/**/*.h"]
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
