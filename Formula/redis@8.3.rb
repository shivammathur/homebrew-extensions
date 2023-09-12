# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT83 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.0.tgz"
  sha256 "901d5a0e52236c1c885a6c970870e089ea46de41d9027a92b6a9bad26ae1cdfd"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "9e39c4c645be458d954f2ebd8c6cf0bfbe4e4d6ef62bb782ca1680279ac67277"
    sha256 cellar: :any,                 arm64_big_sur:  "21c49dab57e7d273204b258e74710b22ae151c8012d03ccd0202bab3e0c079a8"
    sha256 cellar: :any,                 ventura:        "998962a12fafec5574d1680f34230698658f927ee27651e6c87b7ee5a6fa65e4"
    sha256 cellar: :any,                 monterey:       "cc2b53fdb5d5cf1d8c85bb1a82922096c4c979199a7d49ef9a4842af3c655071"
    sha256 cellar: :any,                 big_sur:        "b7f8ddcd9bbb8c4ad1a3329692f2ed076efc57688b2b353507d8791d13c8c764"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e1fcf21940d03ef3b9ffa5661d1b495c2300651bb87f67cda612b317ae14f171"
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
