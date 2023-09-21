# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT56 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-4.3.0.tgz"
  sha256 "c0f04cec349960a842b60920fb8a433656e2e494eaed6e663397d67102a51ba2"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_ventura:  "41ab025b10b8ec462608be5c04ee440aa4e6d3aefe4c08f9bab9ee0c427ce66b"
    sha256 cellar: :any,                 arm64_monterey: "0c10c066273674164449476bc32e5975076429781a234059a7204daf03948c4e"
    sha256 cellar: :any,                 arm64_big_sur:  "5df9f678ce0674af118a52c66531ccfce54b6c45d14e0ad56b7925e7894565a6"
    sha256 cellar: :any,                 ventura:        "3b45366cb34310c519a0d6ed6da8cf3a2b8555baf5750bb6c04f299f80f1341e"
    sha256 cellar: :any,                 monterey:       "d4dac95cba00891f0829b2320e9d30aca9b94bb496a91d4839e64c88d3ed1043"
    sha256 cellar: :any,                 big_sur:        "c647891caced51dd99690d775494b85176a4f692b2d957f170d0308b0f130099"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fd4029f1db1716caef5afe038c6e2b92d214659f4af51daef20051fae3f503e4"
  end

  depends_on "liblzf"
  depends_on "shivammathur/extensions/igbinary@5.6"

  def patch_redis
    mkdir_p "include/php/ext/igbinary"
    headers = Dir["#{Formula["igbinary@5.6"].opt_include}/**/*.h"]
    (buildpath/"redis-#{version}/include/php/ext/igbinary").install_symlink headers unless headers.empty?
  end

  def install
    args = %w[
      --enable-redis
      --enable-redis-igbinary
      --enable-redis-lzf
    ]

    on_macos do
      args << "--with-liblzf=#{Formula["liblzf"].opt_prefix}"
    end

    Dir.chdir "redis-#{version}"
    patch_redis
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
