# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT82 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-3.2.0.tgz"
  sha256 "2a41143a7b29f4a962a3805b77aa207a99e4566e2d314ce98a051cd24d6e9636"
  head "https://github.com/php-memcached-dev/php-memcached.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "bf31b900fb3aec7cab3c2979bbcbfcb8ed8ecf54706a15f0261ed4ad0e4e1db1"
    sha256 cellar: :any,                 arm64_big_sur:  "f20cf6cbb3723f7074633525c1c0b4fc1342e32f299fbb410fd86a9608d74d34"
    sha256 cellar: :any,                 monterey:       "7488cb8c449c1b553d75bc1cfde8bdd38c63121b5488cc149393926b69fbede9"
    sha256 cellar: :any,                 big_sur:        "08ca982bdac0c82b217f7fafc8f10f076de9e0a433ec64b2edbd8cfc6c304058"
    sha256 cellar: :any,                 catalina:       "7de1f6ab3e1e27cd366629f2f8ca536b2beb0726e208dea28cd4059a4faa8d45"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "efb235a1643ac27de5bd6173ae12ced691518b281c960b7a16cd4ff3e281110a"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.2"
  depends_on "shivammathur/extensions/msgpack@8.2"

  uses_from_macos "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.2"].opt_include}/**/*.h"]
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
