# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class PhpredisAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "464468dba64d5f204be31fe74b10f6f2ec322d527a35176d4e5918ff2f36c222"
    sha256 cellar: :any,                 arm64_sequoia: "dff2223bece10a3dbed8425ebf82c7407c729271165aa5d14d58175312b2b40e"
    sha256 cellar: :any,                 arm64_sonoma:  "014358db722b3edd14cdb265f8e2ac50743f076215cee52870451a862a0a3b2a"
    sha256 cellar: :any,                 sonoma:        "3822f0deae1699fa769dec317b2aa8c3a91cc59ae97521250b117b0c5d763444"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9ad13840be2374ede4b9b0118346c90d32a3521c7e6090b7ecd5223e1a39991b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6bcb642ae241aa893536fecb6d54b73f41e4731bdaf3e171a053e73a5d6d4fed"
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
