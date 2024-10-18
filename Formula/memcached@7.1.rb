# typed: true
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
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "199bd351c9d5e8095389a3c79037da47781eaf9ac7a8a2201aed23951c78eb0d"
    sha256 cellar: :any,                 arm64_ventura:  "61ad153f937a67134de3a152a4b5bb4b0e64cae18707fc96238b14c935a7ed81"
    sha256 cellar: :any,                 arm64_monterey: "c54d5333b03dd74aca87535b0fa0eec46e7130e45ea54b148cbf81a9e6e0431f"
    sha256 cellar: :any,                 arm64_big_sur:  "475d40fc5b1dadc1b4ccd5b35ff07df3f567ecae1bfb80ecce6ac97fd3f1a99c"
    sha256 cellar: :any,                 ventura:        "b8311bf11292c194e888f9f98e5ad2ab9359ba097d1571367dbe288cff05efbd"
    sha256 cellar: :any,                 monterey:       "b98acab6021a3eae2f2831597711a9f4d9ab695217f24d652f178e327907261e"
    sha256 cellar: :any,                 big_sur:        "bad005604e8a8cb6641a3dfa8cd29afafba7cc7ce4bfbb8d8881d3fedfa379a5"
    sha256 cellar: :any,                 catalina:       "fa2c137f8de39abcd386c884c83b4445855fd430f755f8c1899eede6117a8072"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2fadaa76b1939753fef9646495875f24d5fac3d5fe45a0700fed3ef22a38713b"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@7.1"
  depends_on "shivammathur/extensions/msgpack@7.1"
  depends_on "zlib"

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
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
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
