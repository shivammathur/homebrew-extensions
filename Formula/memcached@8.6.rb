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
    sha256 cellar: :any,                 arm64_tahoe:   "19b431a103709ab186fc8cf560a1f85642909ac22fe465e6155aeee9e6a5722c"
    sha256 cellar: :any,                 arm64_sequoia: "26abc1470a7424ce3a48afa11e2d5e1794576830f9d1a6e4a4097e8316ce1937"
    sha256 cellar: :any,                 arm64_sonoma:  "2163d4c350665758500dfdd58464a7b8f04ed19adc14c7602a508f9005bf66a2"
    sha256 cellar: :any,                 sonoma:        "e7195bfb85262c66a95507852064edbc9836ba158f609486747971524a905ad0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b76a373b8c16a8ae4f5a1f26db20a1bf18dfbd8d889f33afa2202d38b69a0ca0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "115c2e4a7a49e7ce21c926d68bf137e47917c984a7c28c61502e7ba0650dbe4e"
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
