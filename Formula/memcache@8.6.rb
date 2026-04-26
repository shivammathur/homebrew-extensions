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
  revision 1
  head "https://github.com/websupport-sk/pecl-memcache.git", branch: "main"
  license "PHP-3.0"

  livecheck do
    url "https://pecl.php.net/rest/r/memcache/allreleases.xml"
    regex(/<v>(\d+\.\d+(?:\.\d+)?(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "9744a0117a52754d3c431c92ca8acdffe0895d591ff12d9730f815c01cddbefb"
    sha256 cellar: :any,                 arm64_sequoia: "b9e91cb109af037909dc3840f0d9041cc9f7232c7948f33a6fd6f936160262db"
    sha256 cellar: :any,                 arm64_sonoma:  "a4ca1edd2c82bab29452e5be450784c8d3a0da5ebade4b905d4b881f954f8ad2"
    sha256 cellar: :any,                 sonoma:        "a8b8785e23272e214bff413f1ebe7d039d9a79d0764c367b15987fc45c52dc50"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "229f42ca18c781d6aee9d7230764b6e7987ef6a7bacc82b4cab1600108ea809f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b027d4ac28ae1b7975a024d8956f09d58d2bbf35b7b7b44e9a2124b18947f7d7"
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
    inreplace "src/memcache_session.c", "path = save_path;", "path = ZSTR_VAL(save_path);"
    inreplace "src/memcache.c", "WRONG_PARAM_COUNT;", "zend_wrong_param_count(); RETURN_THROWS();"
    inreplace "src/memcache_session.c", "INI_INT(", "zend_ini_long_literal("
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
