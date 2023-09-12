# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT72 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.0.tgz"
  sha256 "901d5a0e52236c1c885a6c970870e089ea46de41d9027a92b6a9bad26ae1cdfd"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "a4c1c73938865ce795a6ca087ca19400c5e580b5c8f6d6a3c3f013267cdece6a"
    sha256 cellar: :any,                 arm64_big_sur:  "ece1820c2a57a2e22850ddf20368e00780846ac7c7b3c70e5a2cdc847f139e38"
    sha256 cellar: :any,                 ventura:        "f01b62d472b2f1ff4a73c0c5e4a0e0ec652f61b87893c4a50ead5bedf1da6d84"
    sha256 cellar: :any,                 monterey:       "f15ca99a8f1cf1240e600a0efc4b2cf21a34ddba40dba3511c1fabe3a40dc1ec"
    sha256 cellar: :any,                 big_sur:        "c6dd4511650c0f338d9effe484573e49fec442b638866a9531bb7d4e1f83a0cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e56ada36e549602ec9819490888dbfe22d48e67f762bf1715a18bd5ca24a582f"
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
