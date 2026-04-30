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
    rebuild 2
    sha256 cellar: :any,                 arm64_tahoe:   "f30732f1226748fdc54eb1316eca28b98ba26aa1015993ebbae2c105559982a7"
    sha256 cellar: :any,                 arm64_sequoia: "e7b7f4d3fd0cf156005129fa272dd87df6e606b50ff905b529aa154dd9cda733"
    sha256 cellar: :any,                 arm64_sonoma:  "f4043fcab7f50da084789088f521746fd46505eddbc7643c54d149c7fcc95740"
    sha256 cellar: :any,                 sonoma:        "1204bc089eaeee6b52e809044959393810f67d2fa3c94dcf62c4574c975344df"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "67367b739611be7af2df3c14d2446fded812d6abf8cd4b3d424fd20274b8196e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f087009fd04223eb0fa9c0d48d0d0aba6d859985bd16100ddb5f09297e14ca29"
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
