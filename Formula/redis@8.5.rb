# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "2a901c33e984143a2acfc9fe9d75497635e20296ec70e80730ae251bacdd94fd"
    sha256 cellar: :any,                 arm64_sonoma:  "35ae0bc7aea11466a97b3b45c8f4c35cec9ea2f9d6345231dd5a8fcf8cae2066"
    sha256 cellar: :any,                 arm64_ventura: "4b444814db03bf5daf2bd69f484a2d1a7c17bb091bb6cca3c1edbff0a48646ee"
    sha256 cellar: :any,                 ventura:       "c2b4997d2de55ffabff62f94e73507cbed86bff8160ec16d3e7bb293db958acb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b1735e516d1c2a5df3a9f8f2acc5003e173ae19f50c967d0ed5e12c784db6ea8"
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
