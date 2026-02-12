# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT86 < AbstractPhpExtension
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
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "9abacefd20f46148f7e967c5b318eb52fe96137db28e1d29851c0debc425aaf4"
    sha256 cellar: :any,                 arm64_sequoia: "10f1a1b393192990404eaefd1efcc39995a3f2e567b176cb6a0c32618be32ee8"
    sha256 cellar: :any,                 arm64_sonoma:  "6226bf15c26f6c35b196ae557dc2268c22def303f505d144e7927042f7651a9d"
    sha256 cellar: :any,                 sonoma:        "cc6dfd5e07d53b704dbfb05b810d4a709b83db1d9cb6e101e56b50c74ff5fba4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e10645ac63efbfb136354d348995e8bf295a188e7b32861d416fdf38fdcfa298"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fc2c9a7ce81728de6435cec4dfef5825d5b409767d81be687689070d7db3c5f2"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.6"
  depends_on "shivammathur/extensions/msgpack@8.6"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Formula["#{e}@8.6"].opt_include}/**/*.h"]
      (buildpath/"memcached-#{version}/include/php/ext/#{e}").install_symlink headers unless headers.empty?
    end
    inreplace "php_memcached.c", "zval_dtor", "zval_ptr_dtor_nogc"
    inreplace "php_memcached_session.c", "if (strstr(save_path, \"PERSISTENT=\"))",
"if (strstr(ZSTR_VAL(save_path), \"PERSISTENT=\"))"
    inreplace "php_memcached_session.c", "servers = memcached_servers_parse(save_path);",
"servers = memcached_servers_parse(ZSTR_VAL(save_path));"
    inreplace "php_memcached_session.c", "plist_key_len = spprintf(&plist_key, 0, \"memc-session:%s\", save_path);",
"plist_key_len = spprintf(&plist_key, 0, \"memc-session:%s\", ZSTR_VAL(save_path));"
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
