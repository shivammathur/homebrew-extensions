# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT84 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis.git",
      branch:   "develop",
      revision: "6673b5b2bed7f50600aad0bf02afd49110a49d81"
  version "6.0.2"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sonoma:   "24a7b7f52a0cba86eff896c98c22528fea89828d6f40583c859641d85fa223d0"
    sha256 cellar: :any,                 arm64_ventura:  "7f005920d595589b432dd9edfac175c0fa473103b39294c2f4c10a1c701bdbcd"
    sha256 cellar: :any,                 arm64_monterey: "c67262068d8a59c0ad902622bbf0c2d33915c653ed7573cd672759cffe9ce9c0"
    sha256 cellar: :any,                 ventura:        "3f3330eeeda037b891a04168a73fc8f0c9bdda323b4fcbf4ce2dae1e2ad5d400"
    sha256 cellar: :any,                 monterey:       "f520c95b4672a132d186c5bcd36f65e6d8511b2e27bd6f3bbd8409075ef5aef9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fd18e36f828d3e8d594ba55f9945ba7a778f5492283dc0979fef64f09d80e622"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.4"
  depends_on "shivammathur/extensions/msgpack@8.4"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.4"].opt_include}/**/*.h"]
      (buildpath/"include/php/ext/#{e}").install_symlink headers unless headers.empty?
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
