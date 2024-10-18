# typed: true
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
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "d350300e39eb7840d79b5b10e537a986affd499ea0657a14b340699bcec73dae"
    sha256 cellar: :any,                 arm64_ventura:  "435bc71707ee9ca5d70884375b7e369dbb88ca8a3a94e7ffe30e89c458f6360e"
    sha256 cellar: :any,                 arm64_monterey: "bb86289f919b9a435944533fdcab1ae0f36ff98185e7582ddccda15f1045c740"
    sha256 cellar: :any,                 arm64_big_sur:  "edc7e84c3c8db5c7580723ebfffa950e6f134c38f9b990d468c379e61cfca66a"
    sha256 cellar: :any,                 ventura:        "15cb6a4566c2509aa51e8570b4cac1f11a087a6f3eee740dca2b74657fb52c53"
    sha256 cellar: :any,                 monterey:       "81764eab9896dae0639c723d9b0ba255f4a574c14996a7a6aaabd274b8293831"
    sha256 cellar: :any,                 big_sur:        "7e55e5f0f3fd306f42f264fb73c15db451824aceb7a8ba2fab802ca981d76924"
    sha256 cellar: :any,                 catalina:       "a60f68d77ccf146d464a2ce0a59e3acb45984ae125c8b889326ee49ab46fd82a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d5c643f6dee8881c2f27e134d4500448dc9904208641b6f696f7cf5cd413c530"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@7.0"
  depends_on "shivammathur/extensions/msgpack@7.0"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@7.0"].opt_include}/**/*.h"]
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
