# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "49f71d4e344e5e81b9caa28dd508bcc6b4ef8baa1b626d2f3dd953cc7a3db625"
    sha256 cellar: :any,                 arm64_sonoma:   "dd519ebd9ba84474c1cbecd53e9bd914d60298e9d507dbf8d834915a6ec74318"
    sha256 cellar: :any,                 arm64_ventura:  "f19a743783f10fecb1debc1b29da38b7b9e8d192eec7a5a52ca8854995c51822"
    sha256 cellar: :any,                 arm64_monterey: "fd92a4f07712683e12ef38bae046bba3b5558bfa7da6bee2e45f309f4e22abf6"
    sha256 cellar: :any,                 ventura:        "42dccb9bf78e2cb046ae6a7ddcb4a2d9816f69c81a0f182dbd0593de48776a80"
    sha256 cellar: :any,                 monterey:       "143440a0ad4422b35bc8386ca1a09e6cc0ebfd34b821c5184fbdfbb6991252dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "269ec4494b74fc67cc83d9741112e74ab04c397c8586791f76c161d8b08db012"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@7.4"
  depends_on "shivammathur/extensions/msgpack@7.4"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.4"].opt_include}/**/*.h"]
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
