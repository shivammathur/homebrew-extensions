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
    rebuild 3
    sha256 cellar: :any,                 arm64_tahoe:   "e860e2ee438ae3a75928028c42766ec3251982d79784f68ad56f784830803f04"
    sha256 cellar: :any,                 arm64_sequoia: "6a62c23320441484aa789de7ce79bdd7ad71b5f7c4795d3d9395d09152a5a234"
    sha256 cellar: :any,                 arm64_sonoma:  "1dee4ac87283d4035455dc73ba5034cce4f1b59a99ce72f4eee9f2012381c7d8"
    sha256 cellar: :any,                 sonoma:        "d5fadde21876e3af88107a782c5a49ef97bb2f81b530348bc6fa03873694f16b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "69fb03a8fa80c4ef3e92aa640a34f67418443a7e231239472148e1ad8235d9fb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "90a01935f75c6a0d993e559e7c0005e9fe5a25d7efc035d458c61d83090e23a7"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
