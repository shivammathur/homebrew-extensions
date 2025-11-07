# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class PhpredisAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "99a9774f6fcf76b93f229301283ca2c265d27bd924cb007c8a87dcc8b6d41c41"
    sha256 cellar: :any,                 arm64_sequoia: "7333e3168ae124bf25560681452861d6bb5e707af66e48b3dd2a18e260e029b2"
    sha256 cellar: :any,                 arm64_sonoma:  "b56bb9203a0ddcfa7cdccae2177b52c0cd637bf809bbc5463ab5f5b3c50712d8"
    sha256 cellar: :any,                 sonoma:        "f43ec3972a87e1702347e1efbb914ba58bf825bce607d82e7160b57f6b5cb226"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4de71218929be96e27cc18b5edc4eb0b60caf5bc0567123784af19623091adda"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bf67f558ce755c4606d5479206f847ef047ceb70dd05bee67429429487440ac8"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@8.3"
  depends_on "shivammathur/extensions/msgpack@8.3"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.3"].opt_include}/**/*.h"]
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
