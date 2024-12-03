# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT85 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.1.0.tgz"
  sha256 "f10405f639fe415e9ed4ec99538e72c90694d8dbd62868edcfcd6a453466b48c"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "e4a916ada169cb67c1a11dbd0bb5e591d9054618515c6d72af7421c1cb9a37a6"
    sha256 cellar: :any,                 arm64_sonoma:  "25282a670c9a8ced2d46d0bfcba9a98ecb774eaa875db30af3f63f789a82c8ca"
    sha256 cellar: :any,                 arm64_ventura: "9fb83f6082f0b6d0eb6d44c7cac3f808bba31284e1435156ebe48a23930c964c"
    sha256 cellar: :any,                 ventura:       "74d90650a29e9b3e035f1062fc55dfd2848d90820a20259e3407f59a6ca17d59"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9870e0c4472c7997f0186b735f009372875a5bfa1547b598223dc036d5228656"
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
