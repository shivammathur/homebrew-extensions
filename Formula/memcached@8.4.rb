# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT84 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://github.com/php-memcached-dev/php-memcached/archive/dfd038f13c4347fc15835cd9077a960218e01d98.tar.gz"
  sha256 "d4ea5558d6ab246d955e87904c49ac84e06cd474fce911fd2519348ae583631c"
  head "https://github.com/php-memcached-dev/php-memcached.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia: "8c28b69f5ebae81d69b2df17bf317274627e2ac289a228b7fe883a7a111ee435"
    sha256 cellar: :any,                 arm64_sonoma:  "f6fd05f457af0cf967d79671986f00196119996a74dc1cc77cd61df230131f03"
    sha256 cellar: :any,                 arm64_ventura: "32978b3a5536004f1910dbfbbbe047fe8f11d429cf78f32def2c7af2b9afc504"
    sha256 cellar: :any,                 ventura:       "18eeacfd1c67846c7cad0cd8990362879bfe7c7bfb3e6ee21e9c3926bacfb5e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a68119c872c28e3910972fa9f1fe977fc4e3c9aa317857c12caa9e3fcc011894"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.4"
  depends_on "shivammathur/extensions/msgpack@8.4"
  depends_on "zlib"

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
      --with-zlib-dir=#{Formula["zlib"].opt_prefix}
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
