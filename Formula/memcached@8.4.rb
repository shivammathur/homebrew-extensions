# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT84 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-3.2.0.tgz"
  sha256 "2a41143a7b29f4a962a3805b77aa207a99e4566e2d314ce98a051cd24d6e9636"
  head "https://github.com/php-memcached-dev/php-memcached.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sonoma:   "29c7176b4a1dcbd808c883491c8d307ffd0cb6b99bb50970eb7d47c81a9e2281"
    sha256 cellar: :any,                 arm64_ventura:  "08c31100e5dbebc654ac6867e5ff08e999ff89a4ceadb54c186fd0a4a838f64f"
    sha256 cellar: :any,                 arm64_monterey: "b01527fd429840d21a82cbc27ed306d55d4035ce199adaff9fbcbf6e603c5c6b"
    sha256 cellar: :any,                 ventura:        "e8a3d111ef06f9f0050a3838f998839501d1db5d2932b7895b3eaed9f8b28249"
    sha256 cellar: :any,                 monterey:       "46b7dcc2935395ccabe782f13d889338d56bd0c09269daf2bb9519773dbc61a3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bcaa204264503808dbd5fdc7a5fd700a87eca7babb2068a546f6be151910ff4a"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.4"
  depends_on "shivammathur/extensions/msgpack@8.4"

  uses_from_macos "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.4"].opt_include}/**/*.h"]
      (buildpath/"include/php/ext/#{e}").install_symlink headers unless headers.empty?
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
      --with-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    patch_memcached
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
