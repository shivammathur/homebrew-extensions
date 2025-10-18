# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Redis Extension
class RedisAT70 < AbstractPhpExtension
  init
  desc "Redis PHP extension"
  homepage "https://github.com/phpredis/phpredis"
  url "https://pecl.php.net/get/redis-5.3.7.tgz"
  sha256 "b958166ccda4f40bd17c6998f9e2239021ae644467cd8ad5c15def420aad65b0"
  head "https://github.com/phpredis/phpredis.git", branch: "develop"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "6d135192a248326e5187aae756d5fdfedf26b03651623c6c5cec96bfc6f93de7"
    sha256 cellar: :any,                 arm64_sonoma:   "e0fad37d60c48237b055a79f89fa5fe6e4f04ec3969decc014d1f2dd1dc984aa"
    sha256 cellar: :any,                 arm64_ventura:  "2f83a6edebf27742fe2212ae5af323f568fa1501bf9bf203c0cdd40e9416273b"
    sha256 cellar: :any,                 arm64_monterey: "c79572d42d668a2e08c13658a96ad52d186fa6cab073b85874be52b41787fbfc"
    sha256 cellar: :any,                 ventura:        "442c0c87c1315faceb63791837ed4ff6cb54d8c86e42d23da3a2afc2370839ad"
    sha256 cellar: :any,                 monterey:       "e39c38e94fdf86e1e927f3f2bdb2614bd4f19b79fd47c7cc5956c59f29764a2f"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "b4c8e95e89bc834346b39769af39f1c799ffe58e19ea030bc381d2b454bbe7ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ccbcbd97b13d70868a1606e5747332b0e1b2a70f0e65b256c661086e14522c90"
  end

  depends_on "liblzf"
  depends_on "lz4"
  depends_on "shivammathur/extensions/igbinary@7.0"
  depends_on "shivammathur/extensions/msgpack@7.0"
  depends_on "zstd"

  def patch_redis
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.0"].opt_include}/**/*.h"]
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
