# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT70 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-3.2.0.tgz"
  sha256 "2a41143a7b29f4a962a3805b77aa207a99e4566e2d314ce98a051cd24d6e9636"
  head "https://github.com/php-memcached-dev/php-memcached.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "0a22191bae34882934aa650b1111d5e58c5f62f53bd9e361f8d2de8fa64817a1"
    sha256 cellar: :any,                 arm64_big_sur:  "879ac8537dbb7295f61b5bcc0f263bd72785b5b95e94ae6f32de6ffadd8125b5"
    sha256 cellar: :any,                 monterey:       "082ab7e9a0f11b99c5346a185841438479e65f0203d08b0266afd03f5189437f"
    sha256 cellar: :any,                 big_sur:        "826eabc78cf01b6dbab5f51fa3e912197b9a5f8e37f32f8ff2a3385d29235686"
    sha256 cellar: :any,                 catalina:       "803c56fcea6b878942f1ede3db30c7d700523901b0947b240d3c250ea9bd11ab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1fac7a54a6994003b6d16060be5844a9350f92a05025d262969d2c4b04e5c0bb"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@7.0"
  depends_on "shivammathur/extensions/msgpack@7.0"

  uses_from_macos "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.0"].opt_include}/**/*.h"]
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
