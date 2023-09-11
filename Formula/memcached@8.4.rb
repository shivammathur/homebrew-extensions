# typed: false
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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "a7903288844d762518e0f3ed1470ce19d333620ebc3252508679564bc49a4991"
    sha256 cellar: :any,                 arm64_big_sur:  "0b0ad0af85cec5ca665b5687d7523c408a425dfd613dcf7e5d53697416f4c3a7"
    sha256 cellar: :any,                 ventura:        "c624f395eb19e0179525daff4f1f11939ef8b024e8cdd36f4170d597051192ca"
    sha256 cellar: :any,                 monterey:       "0edfe2a4b44106e6d9e842eaf545e44276fcd127fc7f91a6c708db8a73f52199"
    sha256 cellar: :any,                 big_sur:        "e3325922307f1992fd5b545835d46430923018584e4cf841500297640d7a2c45"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2029a1e323b79e3204a081db4d10476929c6912dc4cc1b6370a4c01769030fd7"
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
