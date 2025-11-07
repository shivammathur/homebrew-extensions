# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class PhpredisAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "6cb7040cae11ba5253834b72b241a5507b90dab31d3b047b43039a20557d9496"
    sha256 cellar: :any,                 arm64_sequoia: "52225d5f03b2871d22bc904324ee98362c4cc6087448ca5561d3c27d942fa376"
    sha256 cellar: :any,                 arm64_sonoma:  "db804866fff4888fcb05b6e8c4c0ad39a6ec58bff5701abbd14c1601474a498c"
    sha256 cellar: :any,                 sonoma:        "0787c5b6bfc7e96988a0d8e4abb94fc7e309f61b4d5103edf17a313d259316a0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "434f8c999c60de82d5fdc1be60d9e888f62a3ffb45b14f6b92d6ce998c2e00d4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d3903b6f5013c37f3c4dac067468e1c1188c692fee841abe28125c60a319efec"
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
