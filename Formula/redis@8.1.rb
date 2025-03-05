# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT81 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.1.0.tgz"
  sha256 "f10405f639fe415e9ed4ec99538e72c90694d8dbd62868edcfcd6a453466b48c"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/redis/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "54e032f194b6ce43d5c6b9b43d2b878a693ce7a667b3e8801e7741386a86f02f"
    sha256 cellar: :any,                 arm64_sonoma:  "77b0cf23c0e1c39869f61c242652df50cbca75405dd08b723bbeb2433586c691"
    sha256 cellar: :any,                 arm64_ventura: "d927fa499735b11fb93012e5cc97fb5d28642c6ae20c7de2102ddc60cf46a14e"
    sha256 cellar: :any,                 ventura:       "95e12bc705ff6e49053ac20623ef6dea99b1e124b4cbd29903af34bdc55317d5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "81263d8a04d4a0eb68d3e56337496157b136a1324497df7570e5cdae03760df6"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.1"
  depends_on "shivammathur/extensions/msgpack@8.1"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.1"].opt_include}/**/*.h"]
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
