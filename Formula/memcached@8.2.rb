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
    rebuild 2
    sha256 cellar: :any,                 arm64_big_sur: "c3ed97d717fcbf7f7fe03580ef28c8861df4fc1b5ede6f6ff887be3b584f0091"
    sha256 cellar: :any,                 big_sur:       "1070d90b3fd90f0add9b6cbb30c0a95c7ae59fdd5de28697671e3011c0e2995d"
    sha256 cellar: :any,                 catalina:      "ace019b8e99b27aec01afdfdb60ccd8b4e7c997896be4e1ad8dd55214700d669"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cffe99d964e0e0654e3ce7265ff61fe91d2822d9aa8fdf9a44326931ff74d4f2"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.2"
  depends_on "shivammathur/extensions/msgpack@8.2"

  uses_from_macos "zlib"

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
