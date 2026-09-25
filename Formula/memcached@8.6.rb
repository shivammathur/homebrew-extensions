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
  revision 1
  head "https://github.com/php-memcached-dev/php-memcached.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/memcached/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "c139724b4a42e6e7d0c10917a16a5c5e144aef5c503d322f7ed82873e0eb734a"
    sha256 cellar: :any, arm64_tahoe:       "6661e586e028ef0233f2bf81f5ce5742a48d1708249a0097988d4ed5be8171b6"
    sha256 cellar: :any, arm64_sequoia:     "9215ec963e3ce16bd3febea06814b288e554f9e30fbeda46f10a6665adf01776"
    sha256 cellar: :any, arm64_linux:       "fbd49f2ab463ae82b6aaf6c0b02537807fcad3e0b99ef0b70c342a876d8b45db"
    sha256 cellar: :any, x86_64_linux:      "a6f09b200aceeba852859686cde555d9708bc71397791252063087c480f2c526"
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
