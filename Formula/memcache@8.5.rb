# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "4abc23dffaaf5e8cd7d4906ff37556d64abcda72674d6370646cb62341cbe441"
    sha256 cellar: :any,                 arm64_sequoia: "ee9f9ed5165466afccf52de203fd1f7b764f1408e44d7c10367c3c8b63475279"
    sha256 cellar: :any,                 arm64_sonoma:  "ff3d5c6acc3eb150c0b923e5b5323389c7ee5fabc3330ac6a8b8c6204da612ea"
    sha256 cellar: :any,                 sonoma:        "bdb671cdbb1e9ec27fd709f681a6352e2f0783c7b1db70fd1b6d336778d7e467"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "04d0e001c3c476e69afd8b5f027a37b799fbd869d8714892d725e024078e5c20"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2d6f5654353afd35d608dbbfd4258e7d5238351bf0b4c666ff841e52252a073a"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
