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
  revision 2
  head "https://github.com/websupport-sk/pecl-memcache.git", branch: "main"
  license "PHP-3.0"

  livecheck do
    url "https://pecl.php.net/rest/r/memcache/allreleases.xml"
    regex(/<v>(\d+\.\d+(?:\.\d+)?(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "22bf2ae5bd39aca5986fd36bb4106885912e64d29fbceb2afda1612609fe8a27"
    sha256 cellar: :any, arm64_tahoe:       "4600e8d26b8665cc293fa372f30e907c85076d63c950f3b1b08cd60f03d779ae"
    sha256 cellar: :any, arm64_sequoia:     "01923f36e6e17b4abb15b925ef86e49858255dc57e4a3f9a6b48a0a8320d73f4"
    sha256 cellar: :any, arm64_linux:       "a2a8e105644dba0295cc8c2ee73d1429e98d392f2503a0bf694b63a32adce577"
    sha256 cellar: :any, x86_64_linux:      "db05dbaae71f0befda4c0282c30c047f5fd2ad97634b20825588cbfe5105f3fa"
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
