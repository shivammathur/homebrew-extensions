# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT82 < AbstractPhpExtension
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
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "6275255074adb680714eacffee3bbc3cd0587b7eec9b973a8d5bd3681f177808"
    sha256 cellar: :any,                 big_sur:       "0cedf8906eaa6b7e8f8ec512a566bab6a5201fd4f8daa895b0787007c85b5201"
    sha256 cellar: :any,                 catalina:      "27d9081b3784cb72f3f67f3304f14bca9980343c963513b47d45df71bdc0a37c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "640fc0e11987cd8f123c154b19e0aae26f28d22d1ec50acc0d44cd329b824688"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.2"
  depends_on "shivammathur/extensions/msgpack@8.2"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.2"].opt_include}/**/*.h"]
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
