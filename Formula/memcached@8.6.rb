# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT86 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-3.3.0.tgz"
  sha256 "2b85bf6699497170801fb4d06eb9c9a06bfc551cdead04101dd75c980be9eebf"
  head "https://github.com/php-memcached-dev/php-memcached.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/memcached/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "d42d4faed83bb56073fb013734d768bac931b602e24e64bb65c1d32c9b91ff2d"
    sha256 cellar: :any,                 arm64_sonoma:  "a4caf999cdbda884c13c73cc75197aaaae416a701c7823d2ab7b055b0a04ac8e"
    sha256 cellar: :any,                 arm64_ventura: "c74d3316dcbb944f2dfef41d94f8628eb6c96ce304d3b8e22f8d820b91bd5058"
    sha256 cellar: :any,                 ventura:       "0fa1ed482f2e0bb12cbe623c8da3f3eda51911c741ac110e21a496c46f10f49e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "26e6e38d84106e239b9806a5c7996f30904157a2fbb5020f0d7ad57aa91f2f43"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "16048f37ba14d634e417d647ccc64a754a49a1c880522ce747b66ebe9bedbbdd"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.6"
  depends_on "shivammathur/extensions/msgpack@8.6"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.6"].opt_include}/**/*.h"]
      (buildpath/"memcached-#{version}/include/php/ext/#{e}").install_symlink headers unless headers.empty?
    end
    inreplace "php_memcached_private.h", "ext/standard/php_smart_string.h", "Zend/zend_smart_string.h"
    inreplace "php_memcached.c", "zend_exception_get_default()", "zend_ce_exception"
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
