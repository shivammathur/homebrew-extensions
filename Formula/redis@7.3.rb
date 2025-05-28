# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT73 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.1.0.tgz"
  sha256 "f10405f639fe415e9ed4ec99538e72c90694d8dbd62868edcfcd6a453466b48c"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "4c9be76439412f552669679c8a6fd956854ff892c2193c3077ba08191f219d6d"
    sha256 cellar: :any,                 arm64_sonoma:  "3dba5e9c8f3abb733ac0ae43218590dc71fa22084ec7c465a359a6f35ab4ffa7"
    sha256 cellar: :any,                 arm64_ventura: "50eaa83e55704336f4f75f363e65963206aec7cbe416dc5bc6262aa78ed985db"
    sha256 cellar: :any,                 ventura:       "fa17df50d6e693e78c73631f8b255d63c065c66a6af94112ff74c41ae898829c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6322fa49d728c3724fe3c7aed6498c921fc62522dbc02c8cdb519219a8949072"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "245bf8e2e04283148d0d21ee8b224e94d412c22e24f6da64f9ea57ee0fbb786b"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@7.3"
  depends_on "shivammathur/extensions/msgpack@7.3"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.3"].opt_include}/**/*.h"]
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
