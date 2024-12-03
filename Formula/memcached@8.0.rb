# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT80 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-3.3.0.tgz"
  sha256 "2b85bf6699497170801fb4d06eb9c9a06bfc551cdead04101dd75c980be9eebf"
  head "https://github.com/php-memcached-dev/php-memcached.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "4c9d2b24cd358b432ca78003ef7b44c04e4d4a42dc035baf82639807c2839b33"
    sha256 cellar: :any,                 arm64_ventura:  "cf4babc883b8d7a82d5f9354760e0f94fa7d079d78c3ee7ab50c0a568f41d225"
    sha256 cellar: :any,                 arm64_monterey: "08bfabdbe2673692829b2fed21469cac4af2afcf43e617acde90290a3eccb719"
    sha256 cellar: :any,                 arm64_big_sur:  "17801dc07b502726af2f44b3fdce69efcef2989e7fe24de30856b4e641264a17"
    sha256 cellar: :any,                 ventura:        "ece818246dc2c2f13b862a0e6c6e214cd52d48b47fdb100865f6014f31674da6"
    sha256 cellar: :any,                 monterey:       "f0d48bdf916e7a59a29f99ff96f4a89dde3f1d058bc419b36f4eac47645a4728"
    sha256 cellar: :any,                 big_sur:        "a078f50ef26841744c2579ae854d76f2265b0043a1e86d4b293316c5d1ccd70e"
    sha256 cellar: :any,                 catalina:       "2307dcec2d4087a7e1a7215a6344fc60053d1f74cae3c92f48ace1b8fd062055"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2a26bcd2bf001cd73e668f53b5a9a93733aa34ebb40ff367e17a7d7cd925c1c3"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.0"
  depends_on "shivammathur/extensions/msgpack@8.0"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.0"].opt_include}/**/*.h"]
      (buildpath/"memcached-#{version}/include/php/ext/#{e}").install_symlink headers unless headers.empty?
    end
  end

  priority "30"

  def install
    args = %W[
      --enable-memcached
      --enable-memcached-igbinary
      --enable-memcached-json
      --enable-memcached-msgpack
      --disable-memcached-sasl
      --enable-memcached-session
      --with-libmemcached-dir=#{Formula["libmemcached"].opt_prefix}
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    Dir.chdir "memcached-#{version}"
    patch_memcached
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
