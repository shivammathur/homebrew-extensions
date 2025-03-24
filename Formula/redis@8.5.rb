# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "619d0d181104002a5d63748099ef9394dd61ecf9587e7bbd859c4f0fb933f41b"
    sha256 cellar: :any,                 arm64_sonoma:  "a5913b76c3688d6434de0d8908f02ed09590f4b21b3baa7bc3c31f6e281929cd"
    sha256 cellar: :any,                 arm64_ventura: "4fbd08ca377b1e83bb79e4633127cacc9c4a70b96895ccc7cd79e3679619a725"
    sha256 cellar: :any,                 ventura:       "6eaa3422c49af005e4732995676dbf96d62b5a98b689c6e8f03a9124b18cefeb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ec8bcf3df16612a5102465246570519620eddf335bff639d539f8cd4ed02e4f1"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.5"
  depends_on "shivammathur/extensions/msgpack@8.5"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.5"].opt_include}/**/*.h"]
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
