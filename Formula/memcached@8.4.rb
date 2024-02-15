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
    rebuild 2
    sha256 cellar: :any,                 arm64_sonoma:   "898276defd878c45925692046fca9242a481166802e0a301ddbe91422816f646"
    sha256 cellar: :any,                 arm64_ventura:  "fec2a35ad62d3e58178d8d27360bd070d1914ea4c9279118dae92ada6adcae07"
    sha256 cellar: :any,                 arm64_monterey: "6eb5bc0338d94564df21ebb576a1d1c82112e3aa6e78844004e52f1bbf28b48e"
    sha256 cellar: :any,                 ventura:        "b33b9485d74cf59b76c1809a054355dec6873f12c5e497e46270a97e22175767"
    sha256 cellar: :any,                 monterey:       "8b2dd5938cd23ab683462eda47dff427b0e033d04391863e42aeddf9db5c34f9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "99ebb7d3338da24686a4e0a0ad44bbf3683e01c8e6258298517639b78df371f6"
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
