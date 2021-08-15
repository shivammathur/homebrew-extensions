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
    rebuild 1
    sha256 arm64_big_sur: "6749c9a0372649735c78711f737c6c789cb4dd3dc926046448a3ee3ea926771e"
    sha256 big_sur:       "647cb41149fb99e89a3ceb88d15a89556e1b0509492038023d63f686e75e635c"
    sha256 catalina:      "e12e8e3ca514b3930d009bb7c3358f6a1f7c66e180adf9f2996c5b5499db3ba8"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.1"
  depends_on "shivammathur/extensions/msgpack@8.1"

  on_linux do
    depends_on "cyrus-sasl"
  done

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
      --enable-memcached-sasl
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
