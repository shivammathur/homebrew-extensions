# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "26ee68fd681d3872234877c73489e1eeeda38abe2a1932bc24f7dd8d83e694f9"
    sha256 cellar: :any,                 arm64_sonoma:   "18565bc381d0711d822b71f5ca24d9a9716082e3a7b9f6e34539587219e19194"
    sha256 cellar: :any,                 arm64_ventura:  "785b0ba404ea45b29b0983cf410cd6033896da1fb188c96fad2737fcae8f83a6"
    sha256 cellar: :any,                 arm64_monterey: "6bf6a2806228f6e4d5dcb77dc0867b94a8286a91e81ab50713271ef0685845cc"
    sha256 cellar: :any,                 ventura:        "5c879f712cefd1f1520bfc965cc540fcbf6f024583516e1e93daf619c099bf3b"
    sha256 cellar: :any,                 monterey:       "a76120e520740625db86a866bd059c3637f6ab7b60d4ed8fdb53d08190a9a0a2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6f516df813262c359c41d35377da36018a066b8d38ddb2a7aa2dd990bb430f25"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@7.3"
  depends_on "shivammathur/extensions/msgpack@7.3"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.3"].opt_include}/**/*.h"]
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
