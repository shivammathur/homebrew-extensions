# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT87 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-8.2.tgz"
  sha256 "b3f0640eacdeb9046c6c86a1546d7fb8a4e9f219e5d9a36a287e59b2dd8208e5"
  revision 2
  head "https://github.com/websupport-sk/pecl-memcache.git", branch: "main"
  license "PHP-3.0"

  livecheck do
    url "https://pecl.php.net/rest/r/memcache/allreleases.xml"
    regex(/<v>(\d+\.\d+(?:\.\d+)?(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "c9773cc3c9161144b8d431f2bcd7055f1fb869303ee2d8be0dd7f3974782e35c"
    sha256 cellar: :any, arm64_tahoe:       "4c3f75934ec55c53fc19ec4c56d44092c96920720126b366355282fd4c17b29f"
    sha256 cellar: :any, arm64_sequoia:     "9d917e92712967e21a3463c0462a9998309bd36dc1c6d19f82d9683d2500dacb"
    sha256 cellar: :any, arm64_linux:       "1cd37644f00a27e99e2c02d4f3822fe144451d71f4a0787f43f13ad8575c6c73"
    sha256 cellar: :any, x86_64_linux:      "f184aae13cc4cfaa83b9b374a4fd38ea9143b3c822f497fbbb14b44bb8d3c6fb"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-memcache
      --with-zlib-dir=#{Utils::Path.formula_opt_prefix("zlib")}
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
