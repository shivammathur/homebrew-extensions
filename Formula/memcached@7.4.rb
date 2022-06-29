# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT74 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-3.2.0.tgz"
  sha256 "2a41143a7b29f4a962a3805b77aa207a99e4566e2d314ce98a051cd24d6e9636"
  head "https://github.com/php-memcached-dev/php-memcached.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "297a3d2e7f9ec6540f51982014417f39dc64d5064435dee152ee8f5985d721b1"
    sha256 cellar: :any,                 arm64_big_sur:  "518b0941efc72db2296a6d7f7d4231f6620313fa8805826a299df1fc085e463f"
    sha256 cellar: :any,                 monterey:       "38993f4d217b58263667b8d4a406e3898496147ec429fcb326853b9dcf3a7dcc"
    sha256 cellar: :any,                 big_sur:        "a75c60c64d16553339d5015be511beaa534947329fc4d970e2902b066e547b3d"
    sha256 cellar: :any,                 catalina:       "6f23e2e44bb11ce8ac898a2cf9f10c711c1e89d90af165bc333a76503edc7562"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5489e7127e6a9c6755129d41229144672faa177aeafd195f18302ad0bf2dd4c4"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@7.4"
  depends_on "shivammathur/extensions/msgpack@7.4"

  uses_from_macos "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.4"].opt_include}/**/*.h"]
      (buildpath/"memcached-#{version}/include/php/ext/#{e}").install_symlink headers unless headers.empty?
    end
  end

  def install
    args = %W[
      --enable-memcached
      --enable-memcached-igbinary
      --enable-memcached-json
      --enable-memcached-msgpack
      --disable-memcached-sasl
      --enable-memcached-session
      --with-libmemcached-dir=#{Formula["libmemcached"].opt_prefix}
      --with-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
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
