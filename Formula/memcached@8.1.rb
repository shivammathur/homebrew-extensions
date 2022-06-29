# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT81 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-3.2.0.tgz"
  sha256 "2a41143a7b29f4a962a3805b77aa207a99e4566e2d314ce98a051cd24d6e9636"
  head "https://github.com/php-memcached-dev/php-memcached.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "641ef8fb523707ba561fda9261364e08f1982590ec44e414e65110b37533e48b"
    sha256 cellar: :any,                 arm64_big_sur:  "c541b92623037c104ccf356932b18a26fa88feb751a141be0168176349ab1af6"
    sha256 cellar: :any,                 monterey:       "90aa244c259719b8337d5c3e458ddcc44b741dbc83d4a944f8a6918112acc0a4"
    sha256 cellar: :any,                 big_sur:        "920566197ecf7f4c413408fefb13e72a09fae060e35b85a18be38010db1008ab"
    sha256 cellar: :any,                 catalina:       "f78c79ad7df87062ad761bdf1755d59a937a8e5c4d47209e0b5d01a14b2de206"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "37f3dcccde86bd3d9553517598ea44320dd6d974e041d76e5e9e5c86cfe2d47a"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.1"
  depends_on "shivammathur/extensions/msgpack@8.1"

  uses_from_macos "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.1"].opt_include}/**/*.h"]
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
