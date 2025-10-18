# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "c1858c6c3f54bb5c1beaae313cde3e1b6f59a8d2ba2d66bde619ca39574a2bd8"
    sha256 cellar: :any,                 arm64_sonoma:  "a87082f5cd7fe24889c2e509bbb327720c3de46cd60a2a6fd93f715d41512fb1"
    sha256 cellar: :any,                 arm64_ventura: "777c718496911bd56ef8eb5ba4c77650c902ca4a47913edc5092c2e9bb5b91b4"
    sha256 cellar: :any,                 ventura:       "c408de20687f264f96d85cd320c28887ed496529d84cc23ab56c479874cf4052"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "541bf8b76c3e1d01ab00bc90e4bb71bb3ba6b20c963b9c12d0e0d75cbb73f418"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1664f9aa1adc797ca52c427c2839b2b3147d1678c2f68b30f87928fcfa43704c"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.2"
  depends_on "shivammathur/extensions/msgpack@8.2"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.2"].opt_include}/**/*.h"]
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
