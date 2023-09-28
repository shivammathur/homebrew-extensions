# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT72 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.1.tgz"
  sha256 "d39136e0ef9495f8e775ef7349a97658fb41c526d12d8e517f56274f149e1e4e"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "82f020eda6ad1d79180f85540f34acf02395021ee0201017f84a506e1fe8242d"
    sha256 cellar: :any,                 arm64_monterey: "e81d3605b5f604ce3dbdd90f72fa8dac8fca938adf4dbf3a39ecc27bff529a9f"
    sha256 cellar: :any,                 arm64_big_sur:  "bb1d69c9c0ddeef52ea5fdbb3aeeda98330baf8725bf8792479443337d26c2ad"
    sha256 cellar: :any,                 ventura:        "6c7b21ff2a9f34adcaee0ca6bae68a2aafc6bf73353c0df6383f042d37dfe2d7"
    sha256 cellar: :any,                 monterey:       "57994c92ede4a5f536ef7d961700201f055df0cedeec2494ec8754a6225b9fa7"
    sha256 cellar: :any,                 big_sur:        "84757709590d649d190771febfbd497e8fd373ad595bffcfcbd654dc93a173dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a5cbebb3681e0f8abcc58c5200943da190935656eb8601eef47368f222037e77"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@7.2"
  depends_on "shivammathur/extensions/msgpack@7.2"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.2"].opt_include}/**/*.h"]
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
