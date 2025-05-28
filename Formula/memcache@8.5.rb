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
  head "https://github.com/websupport-sk/pecl-memcache.git", branch: "main"
  license "PHP-3.0"

  livecheck do
    url "https://pecl.php.net/rest/r/memcache/allreleases.xml"
    regex(/<v>(\d+\.\d+(?:\.\d+)?(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "2937c90ae285d8f78d4deff4916632d0909b5b2dbd8fc2a617482b0e06824867"
    sha256 cellar: :any,                 arm64_sonoma:  "5a16d6564e7e8577520d2c8ea058d0724447030d1c56af19a100006c2b82f56b"
    sha256 cellar: :any,                 arm64_ventura: "3968e94509046d4a71725a0e775acc57502e817236c37322531573592c84d68c"
    sha256 cellar: :any,                 ventura:       "0e00fccf41b811d86149c5ccf4e0b800808881840a314385c9fc5ae33e314671"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "703291c82660a8b8c0f0f8202a9308a7efb42e2fc7a70ae32d91674d2bc027a2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c195596b618578df71682b535781f9d507f1a19cf139c25096e2a8a5c50a08b1"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-memcache
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    Dir.chdir "memcache-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
