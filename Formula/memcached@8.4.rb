# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT84 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-3.2.0.tgz"
  sha256 "2a41143a7b29f4a962a3805b77aa207a99e4566e2d314ce98a051cd24d6e9636"
  head "https://github.com/php-memcached-dev/php-memcached.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "4f14eb960a1b616fda1c8c592983dfe5c71453af4b330bf080a1174d0c5ffa8e"
    sha256 cellar: :any,                 arm64_big_sur:  "6e9d755aa7f99efd4819684086fb29f3e06b2b09ecf76bb28c1844c64bed299e"
    sha256 cellar: :any,                 ventura:        "bdf859695dbe0baf8316c3c8d26006588c03e3f29a556e9a81dee593db68b96e"
    sha256 cellar: :any,                 monterey:       "b4b0bd71117551388532629382bc6439c894c58fe2be6f366f21df00abdcd414"
    sha256 cellar: :any,                 big_sur:        "c8d210c4c5c70a117bf9ce13b8219bef667fb7b3964d198eb5e54847f33b8480"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ad63ccbdcec17fa1609af1287b87d955c750a958f5565b8969dede38e0b6ee88"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.4"
  depends_on "shivammathur/extensions/msgpack@8.4"

  uses_from_macos "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.4"].opt_include}/**/*.h"]
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
