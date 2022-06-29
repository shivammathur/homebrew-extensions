# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT80 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-3.2.0.tgz"
  sha256 "2a41143a7b29f4a962a3805b77aa207a99e4566e2d314ce98a051cd24d6e9636"
  head "https://github.com/php-memcached-dev/php-memcached.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "f5b79330997d42fa0b88fac45fa7065fa6127a0cf456504c140be32c57e162a4"
    sha256 cellar: :any,                 arm64_big_sur:  "702f6088a7439139a0fc23b8386941edb0be82d33386dd6c2120ddf6b107d9ff"
    sha256 cellar: :any,                 monterey:       "6a14b2f9dc6c0768ba86ce475d5a79330447ef4707c6d986a17f0dd5dc1b7576"
    sha256 cellar: :any,                 big_sur:        "b3874b7c8f57c862df9d6b8c6bef910e44910ea3ecfaeb4ef7b775f5fb17c386"
    sha256 cellar: :any,                 catalina:       "96f1fbba5fe1d48ed8da3f332b9964b0c64bdee10f83608fdd89b9845e1e1fc9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3a4746d99821432d866fc695677a1cec37f77ee6bb77ce315e4ab4cfd5d6ad46"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.0"
  depends_on "shivammathur/extensions/msgpack@8.0"

  uses_from_macos "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.0"].opt_include}/**/*.h"]
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
