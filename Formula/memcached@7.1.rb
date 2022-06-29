# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT71 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-3.2.0.tgz"
  sha256 "2a41143a7b29f4a962a3805b77aa207a99e4566e2d314ce98a051cd24d6e9636"
  head "https://github.com/php-memcached-dev/php-memcached.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "7bc97c5a1dd2c60cede31d93ebbc1da11a853cb25e904482f508d55d3631a00d"
    sha256 cellar: :any,                 arm64_big_sur:  "dfaec007c7a0cdb795545a731c79f2328b72329e314d98e82551f5031d17d888"
    sha256 cellar: :any,                 monterey:       "2908a0d35edb2e65fe8a899045eaac1c9ba7830e9d04357763306882de9c857b"
    sha256 cellar: :any,                 big_sur:        "f68da12bf56183c7451454074fd461d6902ce26ef8c3c3e13b38011e3e64a7c5"
    sha256 cellar: :any,                 catalina:       "cd368cb35b0ab8585efb1369ea849d06ab0433f3a655613c90273b3f6aa4bf00"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cfe67c0644c7ff5475b7ba1ce63d8a04d6bfe78a723f8b4688ec0c6508b535a8"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@7.1"
  depends_on "shivammathur/extensions/msgpack@7.1"

  uses_from_macos "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.1"].opt_include}/**/*.h"]
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
