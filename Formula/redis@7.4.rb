# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT74 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.2.0.tgz"
  sha256 "5069c13dd22bd9e494bb246891052cb6cc0fc9a1b45c6a572a8be61773101363"
  head "https://github.com/phpredis/phpredis.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/redis/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "617c45d4575bf23eccd2d18b19afbb2594aeff16aa6d9fc6ee704f51a4b2f401"
    sha256 cellar: :any,                 arm64_sonoma:  "f5dd66aea9945a6a64f8de0e5ecdabd9afde6448fc3dc189f87a998a5af6057e"
    sha256 cellar: :any,                 arm64_ventura: "2111735e1998f8e3cb672bcb037cf88e68b8ed4e2dadbbc182aefb10dc2eb7b7"
    sha256 cellar: :any,                 ventura:       "27047d6234a3917a643c0a0697ac17752f6231b29e5c3dd25f3e99efff7f6d6b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "06679596f3eb84d208c15ecb561c5ef53d0bdbf7822714ffcbe3ee96225bd3e1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "86d997d94c14f67725f8254b93d0109ac36f382769015e10925d16571fa85f78"
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
