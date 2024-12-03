# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "eb9c40189756ae4d284380cccf4c7de644885e829037e5e41b3e548c96052f52"
    sha256 cellar: :any,                 arm64_ventura:  "89674abb67159813bbd5cf3637d3866da1f4f394e30af706dc92c301aaed8279"
    sha256 cellar: :any,                 arm64_monterey: "f69d0afe9ee1a579388a73a88c580d2127c914971f01e175f9f8ad3fb750c6b8"
    sha256 cellar: :any,                 arm64_big_sur:  "d54a5e5518c64c37af8c21314424d8d31e63a69e80ae146520e2f1759a2e7910"
    sha256 cellar: :any,                 ventura:        "6d48364c14c1bd974ebb8b513c2ffbef5667b7bcd6c5213a19d04c2f4b44b0eb"
    sha256 cellar: :any,                 monterey:       "7b743e98bd915b39f3eb9dd853a9cd0bc6f88efdbec3366098136d3991d6c6f3"
    sha256 cellar: :any,                 big_sur:        "515a8a9e3aac7acafdd8952694e72c39c30f9008b9c71f620b2a8eaf9512e081"
    sha256 cellar: :any,                 catalina:       "d4e6903271c62d4df19580069e8ed199083b848f3cb5a9a6793779ad74259bcc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "593103c2fcb3c7cd60accfda1beebb3026f17c7bd1af42a85a979154e6faf9cf"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.1"
  depends_on "shivammathur/extensions/msgpack@8.1"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.1"].opt_include}/**/*.h"]
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
