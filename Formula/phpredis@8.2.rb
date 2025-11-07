# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class PhpredisAT82 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.3.0.tgz"
  sha256 "0d5141f634bd1db6c1ddcda053d25ecf2c4fc1c395430d534fd3f8d51dd7f0b5"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/redis/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "e365f51771ac043b26a0afa52d994d82447b2b8e88d737032e0b745e21697307"
    sha256 cellar: :any,                 arm64_sequoia: "bddeb67f4d268cea01f7505782f4949870b0010c86c6495eabba4df89d723d4c"
    sha256 cellar: :any,                 arm64_sonoma:  "7956fc5e6be072819f4577f4beba2d0dc8eb4d15bc81efabf0abf0a4c1c6093c"
    sha256 cellar: :any,                 sonoma:        "e1b7bc9657abf3dd582639d3eaa56751d05ebba42e7ac2586048b44cdc05d8d3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5440eac4dcd7861b99cf28c7adf55ece03a08a138573934f7eff72ff4a9bd1dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a06ec3ab00c7464066ddf693c66f0f9905f8f5b944cee989b0e95e45a8dcb2e9"
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
