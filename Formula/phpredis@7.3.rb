# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class PhpredisAT73 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-6.1.0.tgz"
  sha256 "f10405f639fe415e9ed4ec99538e72c90694d8dbd62868edcfcd6a453466b48c"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "e85295163a23ad9a72455d9b685fc2c76b7a095857d843bfe702633a45d9ddcb"
    sha256 cellar: :any,                 arm64_sequoia: "6a7f6ee11da60750043134a9d632ba98b3c634de36331ea120cc2d7fb3ab11b8"
    sha256 cellar: :any,                 arm64_sonoma:  "1172407d30541e728c1de2d3031e9b387d327e912b99fbd8a0d54af7cdbe980e"
    sha256 cellar: :any,                 sonoma:        "e85cd96f0eaaacdb7edbe27b201e2c48fb7c2722d144940a3c1a3fd9222dacd4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "eb654194089ff50499cc3927fe8706e4b6bcf4bec9f27a7ceedcec3bd1caf80b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "68f25877dc968b2239052ac4617584c2c6d09279b78dc0f54fb5ca8436e6f3ce"
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
