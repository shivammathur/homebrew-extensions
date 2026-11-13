# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcached Extension
class MemcachedAT87 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "85860ead48856ab5aedce89b5f83611ba87956b9bd111389096ccfc0421a5bc6"
    sha256 cellar: :any, arm64_tahoe:       "df33586aa94bcbcb08ff1c09efae67789918f4547e9d02b3ee4d4e77465bfc3b"
    sha256 cellar: :any, arm64_sequoia:     "89085c3bfee4bb8fd765f1305d5de4ef6a7a8b5f2f29fa9d745b7ad24ef77dd2"
    sha256 cellar: :any, arm64_linux:       "efc6c52b10047e3cb02e66f6955f6c369440ae1742c53cf9ed3a3f42baed401d"
    sha256 cellar: :any, x86_64_linux:      "ad1e85727d6572e6870d82dc346c7e51f0a9b1bfe4260b2b4e3a481b2629dab9"
  end

  depends_on "libevent"
  depends_on "libmemcached"
  depends_on "shivammathur/extensions/igbinary@8.7"
  depends_on "shivammathur/extensions/msgpack@8.7"
  depends_on "zlib"

  def patch_memcached
    %w[igbinary msgpack].each do |e|
      mkdir_p "include/php/ext/#{e}"
      headers = Dir["#{Utils::Path.formula_opt_include("#{e}@8.7")}/**/*.h"]
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
