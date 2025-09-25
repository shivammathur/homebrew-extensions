# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT85 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-3.3.0.tgz"
  sha256 "2b85bf6699497170801fb4d06eb9c9a06bfc551cdead04101dd75c980be9eebf"
  revision 1
  head "https://github.com/php-memcached-dev/php-memcached.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/memcached/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "4831497e5f9bf199f761cbe2969f566de53f5ae5130040d6922ef2e5466a106d"
    sha256 cellar: :any,                 arm64_sequoia: "58c0827cff230c5dc2d721a9395fafaf7dc965a03e38791ae8ff86358168330e"
    sha256 cellar: :any,                 arm64_sonoma:  "aed93665b6d852db133944d4418a12503ba63946a0839290c73283bfff1d5215"
    sha256 cellar: :any,                 sonoma:        "946215e38b1a059ed912bef468dcfc82d3b3a5b2b238fb19eabdad2bb053c8ca"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2b0b60a8e612d2a2f84793c3ef1de71d44554f0f6271646deaf1bb1dc1e71d29"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bd8fba264ce7391dc09525b3228381e7480c7bd80f7465338a6eb417d40e264d"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.5"
  depends_on "shivammathur/extensions/msgpack@8.5"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.5"].opt_include}/**/*.h"]
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
