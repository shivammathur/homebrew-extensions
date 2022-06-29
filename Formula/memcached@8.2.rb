# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "90036c3ad97b1aedacaa53011593e36562e716c055e367afb89bce42690cc5b3"
    sha256 cellar: :any,                 arm64_big_sur:  "679fc9c4d9053e8f060a2d468abe8d9425dae44e0fb581dde9c4bc319f2c57a6"
    sha256 cellar: :any,                 monterey:       "6c76ffce222bbe0cc3ba19a92efac196371a073eb3073e172ba791d73a00cbbc"
    sha256 cellar: :any,                 big_sur:        "23adeba63b93da50ccf7adb4b40f7512179c10503c5c636c8750505a9eafecab"
    sha256 cellar: :any,                 catalina:       "7fe94f70f1d43acfb03a32caeebbb06e2c1a097d70984bf475faa7c3d8d53743"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dd82b90fc343a7dab19bad6499305210247ccfb0f1fea5e3e9630a6ee7b95208"
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
