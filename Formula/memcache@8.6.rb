# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT86 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-8.2.tgz"
  sha256 "b3f0640eacdeb9046c6c86a1546d7fb8a4e9f219e5d9a36a287e59b2dd8208e5"
  head "https://github.com/websupport-sk/pecl-memcache.git", branch: "main"
  license "PHP-3.0"

  livecheck do
    url "https://pecl.php.net/rest/r/memcache/allreleases.xml"
    regex(/<v>(\d+\.\d+(?:\.\d+)?(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_tahoe:   "9d959aa6c6365879a636968cd3298fc21805b85af85766e5b5c1059ce4f9ec87"
    sha256 cellar: :any,                 arm64_sequoia: "fde8825dd65be981de450599da647b7c41225977d8da7643daa4b59fe27bbe3e"
    sha256 cellar: :any,                 arm64_sonoma:  "ba095f25b9dc6999b047718d9350e85f84d9ab6745de246acad0ae196413ecf0"
    sha256 cellar: :any,                 sonoma:        "91c12bd4073634092dd3d85ae37b2c013b7d5bf71753373005b5337c1d9d511e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e47be0541631d3546410d099758e6640688c6185881a2fe4b665864588ba4ed1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "783065857a0bd8a9774d4c88cba286bdec9c49d2a455f5b1a72474e5943ea4c3"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-memcache
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    Dir.chdir "memcache-#{version}"
    inreplace %w[
      src/memcache_ascii_protocol.c
      src/memcache_binary_protocol.c
      src/memcache_pool.c
      src/memcache_session.c
    ], "ext/standard/php_smart_string.h", "Zend/zend_smart_string.h"
    inreplace "src/memcache_pool.h", "ext/standard/php_smart_string_public.h", "Zend/zend_smart_string.h"
    inreplace %w[
      src/memcache.c
      src/memcache_binary_protocol.c
      src/memcache_pool.c
      src/memcache_session.c
    ], "zval_dtor", "zval_ptr_dtor_nogc"
    inreplace "src/memcache_session.c", "ZEND_EXTERN_MODULE_GLOBALS(memcache)", <<~EOS
      ZEND_EXTERN_MODULE_GLOBALS(memcache)
      #define ps_create_sid_memcache php_session_create_id
      #define ps_validate_sid_memcache php_session_validate_sid
    EOS
    inreplace "src/memcache.c", "WRONG_PARAM_COUNT;", "zend_wrong_param_count(); RETURN_THROWS();"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
