# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT56 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-2.2.0.tgz"
  sha256 "17b9600f6d4c807f23a3f5c45fcd8775ca2e61d6eda70370af2bef4c6e159f58"
  head "https://github.com/php-memcached-dev/php-memcached.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "f27129e84bc1901df06548ccb5305ecc563b43e5133b92d23237ff935417838d"
    sha256 cellar: :any,                 arm64_ventura:  "cfe5d78c7a49bd0d3032d06aca18598c78cc37024387f4bea3640c9702ad0957"
    sha256 cellar: :any,                 arm64_monterey: "2f73063d145205366522c3a3cb0aaa13bfc7660d11e004040a4d9d99af912014"
    sha256 cellar: :any,                 arm64_big_sur:  "7b24c7b2f8c598a175699a110d7e0e59b4d101454e1697e3df84e5b104ba38c4"
    sha256 cellar: :any,                 ventura:        "0410bc9e0123d1ab8c65e041292f2c8eac0506535a952f45d3bca41318ed98d8"
    sha256 cellar: :any,                 monterey:       "f8a39e14fd96a6a6606f236b192411ba31d8f2487d3e65d72986879a130fe5e7"
    sha256 cellar: :any,                 big_sur:        "c4903ca3df34051904e2b1100012cb082220daa4db7697367a557674d930c665"
    sha256 cellar: :any,                 catalina:       "c29a461b838dc550d4d5c46eb54055b31f409c2c10168f3cb3fd2d19fb1fd20a"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "9b731b4ec68eb2701768b18a99b8c48749a0c6e5bf4658a6f8372c777f7dddfd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5f417b6abf47546302f3efecb0eb00c4540f5382c5dfcc50e73878a23105e7ac"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@5.6"
  depends_on "shivammathur/extensions/msgpack@5.6"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@5.6"].opt_include}/**/*.h"]
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
