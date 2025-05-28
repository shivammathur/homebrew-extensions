# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT83 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.2.0.tgz"
  sha256 "5069c13dd22bd9e494bb246891052cb6cc0fc9a1b45c6a572a8be61773101363"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/redis/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "a91e8d962c3e14cc19ec297ca67788ad23866c123a04874060825aee5997afa9"
    sha256 cellar: :any,                 arm64_sonoma:  "75f86ccc36781642e3e748f1d957bd1b10287e0df12663ed5aa503cacf68d8b9"
    sha256 cellar: :any,                 arm64_ventura: "22a049ee88df6dbf8ac67315613cdf4f57bfbdb6ed372b80d149b5ce00c3c6ce"
    sha256 cellar: :any,                 ventura:       "f5c78cfa3d40dd316c8ca2ff6c4d8f4b20e93f25fce7d013dc59eeab48e840a6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "dcbc2e1e0829bcfec63a1a271cd69b31321b6055233e16e96c48275414f8c3b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c44f30c23274b72cf686912ffbf9935e3d9386dfb6319027f87ea345906b87a2"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.3"
  depends_on "shivammathur/extensions/msgpack@8.3"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.3"].opt_include}/**/*.h"]
      (buildpath/"redis-#{version}/include/php/ext/#{e}").install_symlink headers unless headers.empty?
    end
  end

  def install
    args = %W[
      --enable-redis
      --enable-redis-igbinary
      --enable-redis-lz4
      --enable-redis-lzf
      --enable-redis-msgpack
      --enable-redis-zstd
      --with-liblz4=#{Formula["lz4"].opt_prefix}
      --with-libzstd=#{Formula["zstd"].opt_prefix}
    ]

    on_macos do
      args << "--with-liblzf=#{Formula["liblzf"].opt_prefix}"
    end

    Dir.chdir "redis-#{version}"
    patch_redis
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
