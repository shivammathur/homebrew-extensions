# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT80 < AbstractPhpExtension
  init
  desc "Memcached PHP extension"
  homepage "https://github.com/php-memcached-dev/php-memcached"
  url "https://pecl.php.net/get/memcached-3.4.0.tgz"
  sha256 "c163434eb0da97c8f45c7ad41d979d381f8b81c49402b1b90b063987fb37972e"
  head "https://github.com/php-memcached-dev/php-memcached.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/memcached/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "9721800ef8dceec0eeb94030cb83e6c51a778ee7b714c7963da6ff2249d550ca"
    sha256 cellar: :any,                 arm64_sonoma:  "b44a6dd2bec8eff043424437e8510c843875162929d70c330f394fae6222fd6d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c8e4176659b4714de4e942cf3a77c32b6cbfc5c65cdef04d0db4f3e625d3912d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "15f9ac6cf31ec50dd35f3c4de4a23a85cf3eb13cb736c45cd3febe936215b17b"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.0"
  depends_on "shivammathur/extensions/msgpack@8.0"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.0"].opt_include}/**/*.h"]
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
