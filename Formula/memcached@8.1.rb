# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT81 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://github.com/php-memcached-dev/php-memcached/archive/19a02bb5bfaeb520b857a2d64172f7d2a9615fb3.tar.gz"
  sha256 "63fdeff6398ebbe1c15c89b86a628a2e00305fb36f4304b3a1f5aa097ad098f6"
  version "3.1.5"
  head "https://github.com/php-memcached-dev/php-memcached.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_big_sur: "415b50f2336e987bfe226d8b2f3ed19b9c8fd061f25b3ab68cf0a9bc3d656eec"
    sha256 cellar: :any,                 big_sur:       "4ced284440ce508661d4dbe73d90bf14f884280be9bd5c0246ebe09c2ae5c047"
    sha256 cellar: :any,                 catalina:      "5d21688bc4b84a1ded7f4c497dc2a77cf12eed1c8704834b3830cd809de64cae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "05a00fdfe5293b5a1c16618d206ceb3947801b7a6a0a0dc9455825e6304f5aa1"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.1"
  depends_on "shivammathur/extensions/msgpack@8.1"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.1"].opt_include}/**/*.h"]
      (buildpath/"include/php/ext/#{e}").install_symlink headers unless headers.empty?
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
