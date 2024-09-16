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
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia:  "861bd4525be971451c930dabe1482cd11d5e7192fd3d3c93143782ddac9f2a40"
    sha256 cellar: :any,                 arm64_sonoma:   "0170e2206a6672721420ef84b6171c98ace1e3c2b811a8c9c7e6b7af2cc638b7"
    sha256 cellar: :any,                 arm64_ventura:  "ef9247a9fd1ce563cd52b4e0b1e2c6e91440afc6355c472d4061764c55420bca"
    sha256 cellar: :any,                 arm64_monterey: "83307bdd3d17ef4836ef5837b884a742a53c13a06e03b878533de0dc510632fe"
    sha256 cellar: :any,                 ventura:        "045a8115d20555add7c3443264161fb42d0f81681be771a593366596c45489f3"
    sha256 cellar: :any,                 monterey:       "44adfc13a8b197f7b12e4c1e64678d167ab889d66a0aef05bfbe2b6faae12c83"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c4423249982292fabda8bce752aa2a16a34784045794e625edea19a858fdf500"
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
