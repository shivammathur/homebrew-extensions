# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT82 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.1.0.tgz"
  sha256 "f10405f639fe415e9ed4ec99538e72c90694d8dbd62868edcfcd6a453466b48c"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "814461e7cf7fbeae5968e93fd3e020560a2bc0953b2b51e6398ddfdc795b806f"
    sha256 cellar: :any,                 arm64_sonoma:   "e9135ae71aef020cbc0f9c8ce890c8f9d9ffb2a6716eb76e8234e870d906fa6d"
    sha256 cellar: :any,                 arm64_ventura:  "fc803c23ab24f397b1b4a49c0b73aab84a40fe0f69238ab85f8a8f9aa5260295"
    sha256 cellar: :any,                 arm64_monterey: "c1b466a92240c2cd724557d5ded344647986486bb6a9b656de62710d3eef8fee"
    sha256 cellar: :any,                 ventura:        "d600beedf062a830d7c9acfa0ae1850a3d8e08d32e697097cee963c62bf71421"
    sha256 cellar: :any,                 monterey:       "93acf644720c7763d73e12c93c33d03af050c058b1c3145e2c2e50fa0ce07a00"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f9533f3022e07d8bd864015c85ca7880b25b98afe37846331d2cd73825b3b03e"
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
