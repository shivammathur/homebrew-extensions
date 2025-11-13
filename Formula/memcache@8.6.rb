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
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "c11bcb1ce82d0d9278c83d756dd87e52220ef4cbefe04b697d05dae1d011b0fe"
    sha256 cellar: :any,                 arm64_sequoia: "ed44e093d119e88a90f7040e3413b859114c0ab94a29f35e5efd180b215cee20"
    sha256 cellar: :any,                 arm64_sonoma:  "55eb672d92e85fcac5e66e10613502a515a4d7b4a93341ca18dea43413ca7db6"
    sha256 cellar: :any,                 sonoma:        "d56640e406c662b1af11d3f337e0d57269306e01a1aec79248bfbb6681768d4b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c08ccbba71e3c1fc33d63b4b7b87bc8e93f4ee2b0104351163186623e8fc9bae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c66568073edc1d5718c27b7dda5b7e7a7081323121891c372be2d4b56474b9e2"
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
    inreplace "src/memcache.c", "WRONG_PARAM_COUNT;", "zend_wrong_param_count(); RETURN_THROWS();"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
