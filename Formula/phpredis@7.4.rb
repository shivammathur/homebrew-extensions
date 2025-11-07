# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class PhpredisAT74 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.3.0.tgz"
  sha256 "0d5141f634bd1db6c1ddcda053d25ecf2c4fc1c395430d534fd3f8d51dd7f0b5"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/redis/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "366dff7e593c9e7d3344a27b60777799636d4bf86efb682776b99ad981f1fb2c"
    sha256 cellar: :any,                 arm64_sequoia: "b0fb5deb20540c026adce71306d208bb9af0ae916253f1562f5310178e160a01"
    sha256 cellar: :any,                 arm64_sonoma:  "5434d1de96a89b06f30258f4e3a290b86365af1344dac16bfe3bf50e1d5c9ca0"
    sha256 cellar: :any,                 sonoma:        "3e468febc1ead79cc9b0db7667ccda65e3c3b1be8bbefb6ea2c1c7a4808ec8eb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "43a378641e5c8ad618ef9f6edbb9d6bedc4011a900949b14375ab4cb3a6636c6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9ce41852c3f28e89dde482ba065006392185d3ec2813a2188516877b458a7ca2"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@7.4"
  depends_on "shivammathur/extensions/msgpack@7.4"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.4"].opt_include}/**/*.h"]
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
