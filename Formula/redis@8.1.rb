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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "71195d1c6692ff3232a25e960e5460bdfb41de6568bdad9ed9847d371efae19b"
    sha256 cellar: :any,                 arm64_sonoma:   "2fa93d1975735c99662eb1ce8b89c16557bc8f3d01431f348d26db529a9ed390"
    sha256 cellar: :any,                 arm64_ventura:  "0794be3aed10724c45d5e50c1fd4768827e15502d03a4fa81b50368c9a33ec8f"
    sha256 cellar: :any,                 arm64_monterey: "e1b480efc7884f881a51540b30c32248fce26d418de49ad04ae559190e8a1c55"
    sha256 cellar: :any,                 ventura:        "5eabc11c5cff84297ff104f02d015b083912d873455da58c9abcaf5137bacc24"
    sha256 cellar: :any,                 monterey:       "7d43aa8e74ae92124079d92b8794ba7a714ab73ce28a6159f0f3ac63b0507a3f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "01287a9f01ec692b6b48cd55d204c4f8e3e9b7b56ff28441e72d6019cea6d5a6"
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
