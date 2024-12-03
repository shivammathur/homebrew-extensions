# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "e593f255dd94a21e795ee41ed1df4441985d6caeac84b83817eff09cc7a63387"
    sha256 cellar: :any,                 arm64_ventura:  "cff104cc3cbc0a1fe18b19eecdd9d496e29ae9d8b3db977e592f1314c35c5d2f"
    sha256 cellar: :any,                 arm64_monterey: "9608615429e69cae110dffce48aa084d7dac05f8d757635b633b668a17d49f8e"
    sha256 cellar: :any,                 arm64_big_sur:  "81ee42135714b65c241c7a11de5fb0d43aac1d52bccea086a55055da2b76f35f"
    sha256 cellar: :any,                 ventura:        "72b11a630d7776a2a71f3424462fc67e80c382cdd4d8bbecb9d2c19d9e638363"
    sha256 cellar: :any,                 monterey:       "19eb5f36913eb7a60abda6600b07d408a41e78fa121257a4bfa0806c6fb20e20"
    sha256 cellar: :any,                 big_sur:        "05fb7b69ddeacc73fe3cee6c4eb993eea490f4a31749e7583d61e398d9daed71"
    sha256 cellar: :any,                 catalina:       "df07df18c6b4dfe42574371fc2f8b3d802c62928f44aa5f7d373f0f98855c612"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "10c13b30e3af5133e0f19ad93a9b2385ce5f0fb8107e5039d0c9f80be5f7fcf5"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@7.2"
  depends_on "shivammathur/extensions/msgpack@7.2"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.2"].opt_include}/**/*.h"]
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
    patch_memcached
    Dir.chdir "memcached-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
