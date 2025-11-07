# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class PhpredisAT70 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-5.3.7.tgz"
  sha256 "b958166ccda4f40bd17c6998f9e2239021ae644467cd8ad5c15def420aad65b0"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "8c083313fdf62b11f583a9463bb7230c7a109239b550ba928f928000a5547afa"
    sha256 cellar: :any,                 arm64_sequoia: "10d631fe83209eb82c85dae4341dcf028535f98b252d6082572af43f4a8c25d4"
    sha256 cellar: :any,                 arm64_sonoma:  "875d82fc1e8f29538dc1873bd109bd3700a83210b28243125703d4f31c8a7ef0"
    sha256 cellar: :any,                 sonoma:        "90c1f266110a6556bb511be89a0e9aa168121f8a5af1f29fa0ae18068bdb5205"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f7970b811106637adea16cd827e3be60ffecced97a193a6f68fd18372b732bf3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4f63d99747a400f65bad5476cb66ee267a6c8ab2bec2a1a8fa7e40eaa3ad29e3"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@7.0"
  depends_on "shivammathur/extensions/msgpack@7.0"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.0"].opt_include}/**/*.h"]
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
