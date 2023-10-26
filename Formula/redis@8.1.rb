# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT81 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.0.2.tgz"
  sha256 "01aeccb0e14f897fe56f0509be6e6991ff0ad459f9d34e95e4556d02699b9a03"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "a8ad7def704d7812c7183216998a72cd24122d3f674c09f8e1c3ad552da245df"
    sha256 cellar: :any,                 arm64_ventura:  "252217ac0f13239c1a3ec313392d48caf1d0ce212945816ed2b15e602cb08024"
    sha256 cellar: :any,                 arm64_monterey: "756ac0e860e6786f54c2b4775d8c8d3c060451de5f6358e2b83d57deb4140cf9"
    sha256 cellar: :any,                 ventura:        "65bfb75ef49aecc79494f5724e33c379d897b4a26d2dca90da76451377e0aff7"
    sha256 cellar: :any,                 monterey:       "6797355c7f36d2541cfcf2e6c3d2b7f83dd250689e18ebbd341bac2ab5c8e662"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e9247f01dbf94c44c4be7f024e1a6741abdd710d098113b368d9d67cbd7820af"
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
