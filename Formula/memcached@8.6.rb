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
  revision 2
  head "https://github.com/php-memcached-dev/php-memcached.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/memcached/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "027c25ba9e07c5924ad6a5fde38d375df3b82a840151838ff9536fa2c2f0ba87"
    sha256 cellar: :any, arm64_tahoe:       "42c99458ab6d27705ba6ff42840b377bce663910f87dbbb11d23704cac344c0f"
    sha256 cellar: :any, arm64_sequoia:     "87e478ee4563b5c191b878f64a02ac6086c3a636bb8e9bc7ff68e42ecc27fd0b"
    sha256 cellar: :any, arm64_linux:       "50e7a3a383e5a3e755fd9a5885beb217f9e6140d88b05ee1ee55547bce71cf23"
    sha256 cellar: :any, x86_64_linux:      "1f5b089341fba69a0070a46b57fc575a1d21b715a0fc087ce471fac0ccaa878f"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.6"
  depends_on "shivammathur/extensions/msgpack@8.6"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Utils::Path.formula_opt_include("#{e}@8.6")}/**/*.h"]
      (buildpath/"memcached-#{version}/include/php/ext/#{e}").install_symlink headers unless headers.empty?
    end
    inreplace "php_memcached.c", "zval_dtor", "zval_ptr_dtor_nogc"
    inreplace "php_memcached.c", "XtOffsetOf", "offsetof"
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
      --with-libmemcached-dir=#{Utils::Path.formula_opt_prefix("libmemcached")}
      --with-zlib-dir=#{Utils::Path.formula_opt_prefix("zlib")}
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
