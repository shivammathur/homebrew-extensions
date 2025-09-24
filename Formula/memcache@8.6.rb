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
    sha256 cellar: :any,                 arm64_tahoe:   "322b3e42a428dd8bd5f0487fda764c1f7886e2da13e893d42ee6dbcba2bf97d1"
    sha256 cellar: :any,                 arm64_sequoia: "61dd510a112aeb899aa0f4ce29e44e341e19399f527db604ebded1ab250d1e1d"
    sha256 cellar: :any,                 arm64_sonoma:  "36685acff4139e25fe8e3a159e511c31a9f07f29958babd85f940069130fdff1"
    sha256 cellar: :any,                 sonoma:        "7a56fbde3334ec68365d30cd8417c51462b8f8f94e101c3e91321ceff71fb824"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5f45a2c8e57e05b62048ab87325c64df200a8f585662ed133108fea29b8751b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ffdda9b08bd248518486ed0c960df91303b5d33e6680bb09ac65422ba75302ad"
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
